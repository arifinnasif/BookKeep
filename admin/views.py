from django.shortcuts import render, redirect
from django.db import connection
from django.views import View
from BookKeep.settings import BASE_DIR
from django.contrib import messages
import datetime
import os
from custom_utils import check_if_authorized_manager

import datetime


# Create your views here.
class AdminPanel(View):
    @check_if_authorized_manager
    def get(self, request):
        return render(request, 'admin_panel.html')


class CustomerInfoModel:
    def __init__(self, row):
        self.customerID         = row[0]
        self.name               = row[1]
        if row[2] is None:
            self.address        = ""
        else:
            self.address        = row[2]
        self.email              = row[3]
        self.accountCreatedOn   = row[4].strftime('%Y-%m-%d %H:%M:%S')
        if row[6] is None:
            self.planName       = ""
            self.membershipBoughtOn = ""
        else:
            self.planName       = row[6]
            self.membershipBoughtOn = row[5].strftime('%Y-%m-%d %H:%M:%S')


class AdminCustomerListView(View):
    @check_if_authorized_manager
    def get(self, request):
        cursor = connection.cursor()
        sql = """SELECT CUSTOMER_ID, C.NAME, C.ADDRESS, C.EMAIL, C.ACCOUNT_CREATED_ON, S.MEMBERSHIP_BOUGHT_ON, P.NAME
                FROM CUSTOMERS C
                LEFT OUTER JOIN SUBSCRIBERS S USING (CUSTOMER_ID)
                LEFT OUTER JOIN PLANS P USING (PLAN_ID)"""
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()



        customerInfo = []
        for r in result:
            customerInfo.append(CustomerInfoModel(r))

        context = {
            "customerInfo" : customerInfo,
        }

        return render(request, 'admin_panel_customer_list.html', context)


class AdminBookListView(View):
    @check_if_authorized_manager
    def get(self, request):
        cursor = connection.cursor()
        sql = """SELECT ISBN, B.NAME, A.NAME, B.EDITION, B.RELEASE_DATE, B.PRICE, B.PAGE_COUNT, B.QUANTITY, P.NAME, AUTHOR_ID, PUBLISHER_ID, OFB.OFB_OFFER_ID
                FROM BOOKS B
                LEFT OUTER JOIN WRITES USING (ISBN)
                LEFT OUTER JOIN AUTHORS A USING (AUTHOR_ID)
                LEFT OUTER JOIN PUBLISHERS P USING (PUBLISHER_ID)
                LEFT OUTER JOIN (SELECT ISBN, OFB1.OFFER_ID AS OFB_OFFER_ID
                                FROM OFFER_BOOK OFB1 INNER JOIN OFFERS O ON (OFB1.OFFER_ID = O.OFFER_ID)
                                WHERE O.START_DATE>=SYSDATE - O.PERIOD) OFB USING (ISBN)
                """
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()



        bookInfo = []
        for row in result:
            cursor = connection.cursor()
            sql = """SELECT B_TYPE
                    FROM BOOK_TYPE WHERE ISBN=%s"""
            cursor.execute(sql, [row[0]])
            result2 = cursor.fetchall()
            cursor.close()

            bookType = []

            for r2 in result2:
                bookType.append(r2[0])

            bookInfo.append(
                {
                    "ISBN"           : row[0],
                    "bookName"       : row[1],
                    "authorName"     : row[2],
                    "edition"        : "" if row[3] is None else row[3],
                    "releaseDate"    : "" if row[4] is None else row[4].strftime('%Y-%m-%d'),
                    "price"          : row[5],
                    "pageCount"      : row[6],
                    "quantity"       : row[7],
                    "publisherName"  : row[8],
                    "bookType"       : bookType,
                    "authorID"       : row[9],
                    "publisherID"    : row[10],
                    "offerID"        : row[11],
                }
            )

        cursor = connection.cursor()
        sql = """SELECT AUTHOR_ID, NAME
                FROM AUTHORS"""
        cursor.execute(sql)
        authorList = cursor.fetchall()
        cursor.close()

        cursor = connection.cursor()
        sql = """SELECT PUBLISHER_ID, NAME
                FROM PUBLISHERS"""
        cursor.execute(sql)
        publisherList = cursor.fetchall()
        cursor.close()

        cursor = connection.cursor()
        sql = """SELECT OFFER_ID, NAME
                FROM OFFERS
                WHERE START_DATE >= SYSDATE - PERIOD"""
        cursor.execute(sql)
        offerList = cursor.fetchall()
        cursor.close()

        context = {
            "bookInfo" : bookInfo,
            "authorList" : authorList,
            "publisherList" : publisherList,
            "offerList" : offerList,
        }

        return render(request, 'admin_panel_book_list.html', context)

    @check_if_authorized_manager
    def post(self, request):
        post_type       = request.POST.get("post_type")
        isbn            = request.POST.get("ISBN")

        if post_type == 'offer':
            offerID = request.POST.get('offerID')
            # print(isbn, offerID)
            cursor = connection.cursor()
            cursor.callproc("UPDATE_OFFER_BOOK_INFO",
                                [isbn, offerID,])
            cursor.close()
            return redirect('admin-book-list-view')

        elif post_type == 'add-to-borrowable':
            cursor = connection.cursor()
            ret = cursor.callfunc("ADD_BOOK_TO_BORROWABLE", int, [isbn])
            cursor.close()

            if ret == 0:
                messages.error(request, 'Not enough books')
            else:
                messages.success(request, 'Added to borrowables')
            return redirect('admin-book-list-view')






        bookName        = request.POST.get("bookName")
        edition         = request.POST.get("edition")
        releaseDate     = datetime.datetime.strptime(request.POST.get("releaseDate"), '%Y-%m-%d')
        bookType        = request.POST.get("bookType").split(",")
        try:
            if request.POST.get("authorID") is None or len(request.POST.get("authorID")) == 0:
                messages.error('Provide an Author Name')
                return redirect('admin-book-list-view')
            authorID        = int(request.POST.get("authorID"))
            price           = float(request.POST.get("price"))
            pageCount       = int(request.POST.get("pageCount"))
            quantity        = int(request.POST.get("quantity"))
            publisherID     = int(request.POST.get("publisherID"))
        except ValueError:
            messages.error(request, 'Something went wrong')
            return redirect('admin-book-list-view')
        uploaded_pic    = request.FILES.get('coverPic')

        if len(isbn) == 0:
            messages.error(request, 'ISBN cannot be blank')
            return redirect('admin-book-list-view')
        elif len(bookName) > 63:
            messages.error(request, 'Name should be less than 64 characters')
            return redirect('admin-book-list-view')
        elif len(bookName) == 0:
            messages.error(request, 'Name cannot be blank')
            return redirect('admin-book-list-view')
        elif price <= 0:
            messages.error(request, 'Price should be a positive value')
            return redirect('admin-book-list-view')
        elif pageCount <= 0:
            messages.error(request, 'Page count should be a positive value')
            return redirect('admin-book-list-view')
        elif quantity < 0:
            messages.error(request, 'Quantity should be a non-negative value')
            return redirect('admin-book-list-view')

        if post_type == "edit":
            cursor = connection.cursor()
            cursor.callproc("UPDATE_BOOK_INFO",
                                [isbn, bookName, authorID, edition, releaseDate, price, pageCount, quantity, publisherID,])
            cursor.close()

            cursor = connection.cursor()
            sql =   """
                    DELETE FROM BOOK_TYPE
                    WHERE ISBN = %s
                    """
            cursor.execute(sql, [isbn])
            cursor.close()



            for i2 in bookType:
                cursor = connection.cursor()
                sql =   """
                        INSERT INTO BOOK_TYPE
                            (
                                ISBN,
                                B_TYPE
                            )
                        VALUES
                            (
                                %s,
                                %s
                            )
                        """
                cursor.execute(sql, [isbn, i2.strip()])
                cursor.close()
            messages.success(request, 'Successfully updated')
        elif post_type == "add":
            cursor = connection.cursor()
            sql = """SELECT COUNT(*)
                    FROM BOOKS WHERE ISBN=%s"""
            cursor.execute(sql, [isbn])
            cnt = cursor.fetchall()
            cursor.close()
            if int(cnt[0][0]) > 0:
                messages.error(request, 'Book with the same ISBN already exists in the table')
                return redirect('admin-book-list-view')
            cursor = connection.cursor()
            cursor.callproc("INSERT_BOOK_INFO",
                                [isbn, bookName, authorID, edition, releaseDate, price, pageCount, quantity, publisherID,])
            cursor.close()

            for i2 in bookType:
                cursor = connection.cursor()
                sql =   """
                        INSERT INTO BOOK_TYPE
                            (
                                ISBN,
                                B_TYPE
                            )
                        VALUES
                            (
                                %s,
                                %s
                            )
                        """
                cursor.execute(sql, [isbn, i2.strip()])
                cursor.close()
            messages.success(request, 'Successfully added')




        if uploaded_pic is not None:
            uploaded_pic_ext = uploaded_pic.name.split('.')[-1]
            cover_pic = open(os.path.join(BASE_DIR, 'static', 'book_cover', isbn+"."+uploaded_pic_ext), 'wb')
            for chunk in uploaded_pic.chunks():
                cover_pic.write(chunk)
            cover_pic.close()


        #print(request.POST.get("test1"))
        return redirect('admin-book-list-view')


class AdminAuthorListView(View):
    @check_if_authorized_manager
    def get(self, request):
        cursor = connection.cursor()
        sql =   """
                SELECT A.NAME, A.DOB, A.DOD, A.ABOUT, (SELECT COUNT(*) FROM WRITES W WHERE W.AUTHOR_ID = A.AUTHOR_ID), AUTHOR_ID
                FROM AUTHORS A
                """
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()

        authorInfo = []
        for r in result:
            authorInfo.append({
                "authorName" : r[0],
                "DOB" : r[1].strftime('%Y-%m-%d') if r[1] is not None else "-",
                "DOD" : r[2].strftime('%Y-%m-%d') if r[2] is not None else "-",
                "about" : r[3] if r[2] is not None else "-",
                "cnt_books" : r[4],
                "authorID" : r[5],
            })





        context = {
            "authorInfo" : authorInfo,
        }

        return render(request, 'admin_panel_author_list.html', context)

    @check_if_authorized_manager
    def post(self, request):
        # print(request.POST.get("post_type"))
        post_type = request.POST.get("post_type")
        uploaded_pic = request.FILES.get('profileImage')

        if post_type == "delete":
            authorID = request.POST.get("authorID")

            try:
                authorID = int(authorID)
            except ValueError:
                messages.error(request, 'Something went wrong')
                return redirect('admin-author-list-view')

            cursor = connection.cursor()
            print(type(authorID))
            sql =   """
                    SELECT COUNT(*)
                    FROM WRITES
                    WHERE AUTHOR_ID=%s
                    """
            cursor.execute(sql,[authorID])
            result = cursor.fetchall()
            cursor.close()

            if int(result[0][0]) != 0:
                messages.error(request, "Cannot delete an author who has some books")
                return redirect('admin-author-list-view')

            cursor = connection.cursor()
            sql =   """
                    DELETE FROM AUTHORS WHERE AUTHOR_ID = %s
                    """
            cursor.execute(sql,[authorID])
            cursor.close()
            return redirect('admin-author-list-view')

        # print(request.POST.get("authorName"))
        # print(request.POST.get("DOB"))
        # print(request.POST.get("DOD"))
        # print(request.POST.get("about"))
        authorName = request.POST.get("authorName")
        if len(authorName) == 0:
            messages.error(request, "Set a name for the author")
            return redirect('admin-author-list-view')
        DOB = request.POST.get("DOB")
        DOD = request.POST.get("DOD")
        about = request.POST.get("about")
        if post_type == "edit":
            authorID = request.POST.get("authorID")

            try:
                authorID = int(authorID)
            except ValueError:
                messages.error(request, 'Something went wrong')
                return redirect('admin-author-list-view')
            cursor = connection.cursor()
            sql =   """
                    UPDATE AUTHORS
                    SET
                        NAME = %s ,
                        DOB = TO_DATE(%s, 'yyyy-mm-dd') ,
                        DOD = TO_DATE(%s, 'yyyy-mm-dd') ,
                        ABOUT = %s
                    WHERE
                        AUTHOR_ID = %s
                    """
            cursor.execute(sql, [authorName, DOB, DOD, about, authorID])
            cursor.close()
            messages.success(request, "Successfully updated")
        elif post_type == "add":
            cursor = connection.cursor()
            # sql =   """
            #         INSERT INTO AUTHORS (
            #             NAME,
            #             DOB,
            #             DOD,
            #             ABOUT
            #             )
            #         VALUES (%s, TO_DATE(%s, 'yyyy-mm-dd'), TO_DATE(%s, 'yyyy-mm-dd'), %s)
            #         """
            # cursor.execute(sql, [authorName, DOB, DOD, about])
            out_var = cursor.var(int).var # ei line mela pera dise
            #out_var = -1
            DOB = datetime.datetime.strptime(DOB, '%Y-%m-%d') if len(DOB) != 0 else None
            DOD = datetime.datetime.strptime(DOD, '%Y-%m-%d') if len(DOD) != 0 else None
            cursor.callproc("INSERT_AUTHOR_INFO",[authorName, DOB, DOD, about, out_var])
            #authorID = int(out_var.getvalue())

            authorID = out_var.getvalue()
            cursor.close()
            messages.success(request, "Successfully added")

        if uploaded_pic is not None:
            uploaded_pic_ext = uploaded_pic.name.split('.')[-1]
            author_pic = open(os.path.join(BASE_DIR, 'static', 'author_pics', str(authorID)+"."+uploaded_pic_ext), 'wb')
            for chunk in uploaded_pic.chunks():
                author_pic.write(chunk)
            author_pic.close()

        return redirect('admin-author-list-view')


class AdminOrderLogView(View):
    @check_if_authorized_manager
    def get(self, request):
        cursor = connection.cursor()
        sql =   """
                SELECT O.ORDER_ID, CUSTOMER_ID, C.NAME, C.ADDRESS, O.ORDERING_DATE, O.DELIVERY_DATE, (SELECT SUM(OB.UNIT_PRICE*OB.QUANTITY) FROM ORDER_BOOK OB WHERE OB.ORDER_ID = O.ORDER_ID)
                FROM ORDERS O
                LEFT OUTER JOIN CUSTOMERS C USING (CUSTOMER_ID)
                ORDER BY O.DELIVERY_DATE DESC, O.ORDERING_DATE DESC
                """
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()

        pending_orders = []
        completed_orders = []

        for r in result:
            cursor = connection.cursor()
            sql =   """
                    SELECT B.NAME, OB.QUANTITY
                    FROM ORDER_BOOK OB
                    LEFT OUTER JOIN BOOKS B USING(ISBN)
                    WHERE OB.ORDER_ID = %s
                    """
            cursor.execute(sql,[int(r[0])])
            result2 = cursor.fetchall()
            cursor.close()
            items = []

            for r2 in result2:
                items.append({
                    'bookName' : r2[0],
                    'quantity' : r2[1],
                })

            if r[5] is None:
                pending_orders.append({
                    'orderID' : r[0],
                    'customerID' : r[1],
                    'customerName' : r[2],
                    'address' : r[3],
                    'orderingDate' : r[4].strftime('%Y-%m-%d %H:%M:%S'),
                    'items' : items,
                    'charge' : r[6],
                })
            else:
                completed_orders.append({
                    'orderID' : r[0],
                    'customerID' : r[1],
                    'customerName' : r[2],
                    'address' : r[3],
                    'orderingDate' : r[4].strftime('%Y-%m-%d %H:%M:%S'),
                    'deliveryDate' : r[5].strftime('%Y-%m-%d %H:%M:%S'),
                    'items' : items,
                    'charge' : r[6],
                })

        context = {
            "pending_orders" : pending_orders,
            "completed_orders" : completed_orders,
        }
        return render(request, 'admin_panel_order_log.html', context)

    @check_if_authorized_manager
    def post(self, request):
        cursor = connection.cursor()
        sql =   """
                UPDATE ORDERS SET DELIVERY_DATE = %s WHERE ORDER_ID = %s
                """
        cursor.execute(sql,[datetime.datetime.now(), request.POST.get('orderID')])
        cursor.close()
        return redirect('admin-order-log-view')


class AdminPublisherListView(View):
    @check_if_authorized_manager
    def get(self, request):
        cursor = connection.cursor()
        sql =   """
                SELECT P.NAME, (SELECT COUNT(*) FROM BOOKS B WHERE B.PUBLISHER_ID = P.PUBLISHER_ID), P.OFFICE_LOCATION, P.PUBLISHER_ID
                FROM PUBLISHERS P
                """
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()

        publisherInfo = []
        for r in result:
            cursor = connection.cursor()
            sql =   """
                    SELECT CONTACT_NUMBER
                    FROM PUBLISHER_CONTACT_NUMBER
                    WHERE PUBLISHER_ID = %s
                    """
            cursor.execute(sql,[int(r[3])])
            result2 = cursor.fetchall()
            cursor.close()

            contact_numbers = []
            for r2 in result2:
                contact_numbers.append(r2[0])


            publisherInfo.append({
                "publisherName" : r[0],
                "cnt_books" : r[1],
                "contact_numbers" : contact_numbers,
                "address" : r[2],
                "publisherID" : r[3],
            })




        context = {
            "publisherInfo" : publisherInfo,
        }

        return render(request, 'admin_panel_publisher_list.html', context)

    @check_if_authorized_manager
    def post(self, request):
        # print(request.POST.get("post_type"))
        post_type = request.POST.get("post_type")

        if post_type == "delete":
            publisherID = request.POST.get("publisherID")

            try:
                publisherID = int(publisherID)
            except ValueError:
                messages.error(request, 'Something went wrong')
                return redirect('admin-publisher-list-view')

            cursor = connection.cursor()
            sql =   """
                    SELECT COUNT(*)
                    FROM BOOKS
                    WHERE PUBLISHER_ID=%s
                    """
            cursor.execute(sql,[publisherID])
            result = cursor.fetchall()
            cursor.close()

            if int(result[0][0]) != 0:
                messages.error(request, "Cannot delete a publisher who has some books")
                return redirect('admin-publisher-list-view')

            cursor = connection.cursor()
            sql =   """
                    DELETE FROM PUBLISHERS WHERE PUBLISHER_ID = %s
                    """
            cursor.execute(sql,[publisherID])
            cursor.close()
            return redirect('admin-publisher-list-view')

        # print(request.POST.get("authorName"))
        # print(request.POST.get("DOB"))
        # print(request.POST.get("DOD"))
        # print(request.POST.get("about"))
        publisherName = request.POST.get("publisherName")
        if len(publisherName) == 0:
            messages.error(request, "Set a name for the publisher")
            return redirect('admin-publisher-list-view')
        address = request.POST.get("address")
        contact_numbers = request.POST.get('contact_numbers').split(",")
        if post_type == "edit":
            publisherID = request.POST.get("publisherID")

            try:
                publisherID = int(publisherID)
            except ValueError:
                messages.error(request, 'Something went wrong')
                return redirect('admin-author-list-view')

            cursor = connection.cursor()
            sql =   """
                    UPDATE PUBLISHERS
                    SET
                        NAME = %s ,
                        OFFICE_LOCATION = %s
                    WHERE
                        PUBLISHER_ID = %s
                    """
            cursor.execute(sql, [publisherName, address, publisherID])
            cursor.close()


            cursor = connection.cursor()
            sql =   """
                    DELETE FROM PUBLISHER_CONTACT_NUMBER
                    WHERE PUBLISHER_ID = %s
                    """
            cursor.execute(sql, [publisherID])
            cursor.close()



            for i2 in contact_numbers:
                cursor = connection.cursor()
                sql =   """
                        INSERT INTO PUBLISHER_CONTACT_NUMBER
                            (
                                PUBLISHER_ID,
                                CONTACT_NUMBER
                            )
                        VALUES
                            (
                                %s,
                                %s
                            )
                        """
                cursor.execute(sql, [publisherID, i2.strip()])
                cursor.close()





            messages.success(request, "Successfully updated")
        elif post_type == "add":
            cursor = connection.cursor()
            sql =   """
                    SELECT PUBLISHER_ID_AUTOINCREMENT_SEQ.NEXTVAL FROM DUAL
                    """
            cursor.execute(sql)
            publisherID = int(cursor.fetchall()[0][0])
            cursor.close()


            cursor = connection.cursor()
            sql =   """
                    INSERT INTO PUBLISHERS
                        (
                            PUBLISHER_ID,
                            NAME,
                            OFFICE_LOCATION
                        )
                    VALUES
                        (
                            %s,
                            INITCAP(%s),
                            %s
                        )
                    """
            cursor.execute(sql, [publisherID, publisherName, address])
            cursor.close()


            for i2 in contact_numbers:
                cursor = connection.cursor()
                sql =   """
                        INSERT INTO PUBLISHER_CONTACT_NUMBER
                            (
                                PUBLISHER_ID,
                                CONTACT_NUMBER
                            )
                        VALUES
                            (
                                %s,
                                %s
                            )
                        """
                cursor.execute(sql, [publisherID, i2.strip()])
                cursor.close()




            messages.success(request, "Successfully added")


        return redirect('admin-publisher-list-view')


class AdminOfferListView(View):
    @check_if_authorized_manager
    def get(self, request):
        cursor = connection.cursor()
        sql =   """
                SELECT OFFER_ID, NAME, DISCOUNT_PCT, START_DATE, PERIOD
                FROM OFFERS
                """
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()

        upcomingOfferInfo = []
        ongoingOfferInfo = []
        pastOfferInfo = []
        for r in result:
            cursor = connection.cursor()
            sql =   """
                    SELECT B.NAME
                    FROM OFFER_BOOK OB INNER JOIN BOOKS B USING (ISBN)
                    WHERE OB.OFFER_ID = %s
                    """
            cursor.execute(sql,[int(r[0])])
            result2 = cursor.fetchall()
            cursor.close()

            books_with_this_offer = []
            for r2 in result2:
                books_with_this_offer.append(r2[0])

            temp_dict = {
                "offerID" : r[0],
                "offerName" : r[1],
                "discount_pct" : r[2]*100,
                "start_date" : r[3].strftime('%Y-%m-%d'),
                "period" : r[4],
                "books_with_this_offer" : books_with_this_offer,
            }

            if r[3] > datetime.datetime.now():
                upcomingOfferInfo.append(temp_dict)
            elif r[3]+datetime.timedelta(days = int(r[4])) < datetime.datetime.now():
                pastOfferInfo.append(temp_dict)
            else:
                ongoingOfferInfo.append(temp_dict)




        context = {
            "upcomingOfferInfo" : upcomingOfferInfo,
            "ongoingOfferInfo" : ongoingOfferInfo,
            "pastOfferInfo" : pastOfferInfo,
        }

        return render(request, 'admin_panel_offer_list.html', context)

    @check_if_authorized_manager
    def post(self, request):
        print(request.POST)
        post_type = request.POST.get('post_type')
        if post_type == 'delete':
            offerID = request.POST.get('offerID')

            if offerID is None:
                messages.error(request, 'Cannot perform delete operation')
                return redirect('admin-offer-list-view')

            cursor = connection.cursor()
            sql =   """
                SELECT COUNT(*)
                FROM OFFERS
                WHERE OFFER_ID = %s AND START_DATE > %s
                """
            cursor.execute(sql, [offerID, datetime.datetime.now()])
            result = cursor.fetchall()
            cursor.close()

            if int(result[0][0]) == 0:
                messages.error(request, 'Cannot delete an offer that has already started')
                return redirect('admin-offer-list-view')

            cursor = connection.cursor()
            sql =   """
                    DELETE FROM OFFERS WHERE OFFER_ID = %s
                    """
            cursor.execute(sql, [offerID])
            messages.success(request, 'Successfully deleted')
            cursor.close()
            return redirect('admin-offer-list-view')


        offerName = request.POST.get('offerName')
        discount_pct = request.POST.get('discount_pct')
        start_date = request.POST.get('start_date')
        period = request.POST.get('period')

        if offerName is None or discount_pct is None or start_date is None or period is None:
            messages.error(request, 'No field can be blank')
            return redirect('admin-offer-list-view')

        try:
            discount_pct = float(discount_pct)
            if discount_pct <=0 or discount_pct > 100:
                raise ValueError;
            discount_pct = discount_pct/100;
        except ValueError:
            messages.error(request, 'Provide a valid discount rate')
            return redirect('admin-offer-list-view')

        try:
            period = int(period)
            if period <= 0:
                raise ValueError;
        except ValueError:
            messages.error(request, 'Provide a valid period')
            return redirect('admin-offer-list-view')

        if datetime.datetime.strptime(start_date, '%Y-%m-%d') <=datetime.datetime.now():
            messages.error(request, 'Offer cannot have a start date in the past')
            return redirect('admin-offer-list-view')

        if post_type == 'edit':
            offerID = request.POST.get('offerID')
            if offerID is None:
                messages.error(request, 'No field can be blank')
                return redirect('admin-offer-list-view')

            cursor = connection.cursor()
            sql =   """
                    UPDATE OFFERS SET NAME = %s, DISCOUNT_PCT = %s, START_DATE = TO_DATE(%s, 'yyyy-mm-dd'), PERIOD = %s
                    WHERE OFFER_ID = %s
                    """
            cursor.execute(sql, [offerName, discount_pct, start_date, period, offerID])
            messages.success(request, 'Successfully updated')
            cursor.close()

        elif post_type == 'add':
            cursor = connection.cursor()
            sql =   """
                    INSERT INTO OFFERS (NAME, DISCOUNT_PCT, START_DATE, PERIOD) VALUES(%s, %s, TO_DATE(%s, 'yyyy-mm-dd'), %s)
                    """
            cursor.execute(sql, [offerName, discount_pct, start_date, period])
            messages.success(request, 'Successfully added')
            cursor.close()

        return redirect('admin-offer-list-view')


class AdminBorrowsView(View):
    @check_if_authorized_manager
    def get(self, request):
        # book currently occupied
        # book that are available
        # reqs with check flag

        cursor = connection.cursor()
        cursor.callproc("REMOVE_EXPIRED_SUBSCRIBERS", [datetime.datetime.now()])
        cursor.close()

        cursor = connection.cursor()
        sql = """
            SELECT BRS.BORROWABLE_ITEM_ID, BRS.CUSTOMER_ID, BKS.ISBN, BKS.NAME, BRS.START_DATE
		    FROM BORROWS BRS
            INNER JOIN BORROWABLE_ITEMS BRITMS ON (BRS.BORROWABLE_ITEM_ID = BRITMS.BORROWABLE_ITEM_ID)
            INNER JOIN BOOKS BKS ON (BRITMS.ISBN = BKS.ISBN)
            WHERE BRS.END_DATE IS NULL
            ORDER BY BRS.START_DATE ASC
	       """
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()

        occupied_books = []
        for r in result:
            occupied_books.append({
                "borrowableItemID" : r[0],
                "customerID" : r[1],
                "ISBN" : r[2],
                "bookName" : r[3],
                "startDate" : r[4].strftime('%Y-%m-%d %H:%M:%S'),
            })

        cursor = connection.cursor()
        sql = """
            SELECT A.BORROWABLE_ITEM_ID, ISBN, B.NAME
            FROM BORROWABLE_ITEMS A
            INNER JOIN BOOKS B USING (ISBN)

            WHERE A.BORROWABLE_ITEM_ID IN

            (((SELECT BORROWABLE_ITEM_ID FROM BORROWABLE_ITEMS)
            MINUS
            (SELECT BORROWABLE_ITEM_ID FROM BORROWS WHERE END_DATE IS NULL))
            MINUS
            SELECT BORROWABLE_ITEM_ID FROM EXPIRED)
	       """
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()


        available_books = []
        for r in result:
            available_books.append({
                "borrowableItemID" : r[0],
                "ISBN" : r[1],
                "bookName" : r[2],
            })

        cursor = connection.cursor()
        sql = """
            SELECT R.CUSTOMER_ID, ISBN, B.NAME FROM REQUESTS R INNER JOIN BOOKS B USING (ISBN)
	       """
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()

        reqs = []
        for r in result:
            # cursor = connection.cursor()
            # sql = """
            #     SELECT COUNT(*)
		    #     FROM BORROWS A
		    #     INNER JOIN BORROWABLE_ITEMS B USING(BORROWABLE_ITEM_ID)
		    #     WHERE A.CUSTOMER_ID = %s AND B.ISBN = %s
    	    #    """
            # cursor.execute(sql, [r[0], r[1]])
            # result2 = cursor.fetchall()
            # cursor.close()
            #
            # asking_for_same_book=False
            # if int(result2[0][0] != 0):
            #     asking_for_same_book=True
            reqs.append({
                "customerID" : r[0],
                "ISBN" : r[1],
                "bookName" : r[2],
            })

        cursor = connection.cursor()
        sql = """
            SELECT E.CUSTOMER_ID, E.BORROWABLE_ITEM_ID, E.ISSUE_DATE, E.EXPIRED_ID,
		          (SELECT NAME FROM BOOKS B
		                WHERE B.ISBN = (SELECT BR.ISBN FROM BORROWABLE_ITEMS BR WHERE BR.BORROWABLE_ITEM_ID = E.BORROWABLE_ITEM_ID ) )
            FROM EXPIRED E
            ORDER BY E.ISSUE_DATE DESC
	       """
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()

        expired_books = []
        for r in result:
            expired_books.append({
                "customerID" : r[0],
                "borrowableItemID" : r[1],
                "issueDate" : r[2].strftime('%Y-%m-%d %H:%M:%S'),
                "bookName" : r[4],
                "expiredID" :r[3],
            })

        context = {
            "occupied_books" : occupied_books,
            "available_books" : available_books,
            "expired_books" : expired_books,
            "reqs" : reqs,
        }

        return render(request, 'admin_panel_borrows.html', context)

    @check_if_authorized_manager
    def post(self, request):
        print(request.POST)
        post_type = request.POST.get('post_type')
        customerID = request.POST.get('customerID')


        if post_type == 'received':
            borrowableItemID = int(request.POST.get('borrowableItemID'))

            cursor = connection.cursor()
            sql =   """
                UPDATE BORROWS SET END_DATE = %s WHERE CUSTOMER_ID = %s AND BORROWABLE_ITEM_ID = %s
                """
            cursor.execute(sql, [datetime.datetime.now(), customerID, borrowableItemID])
            cursor.close()


        elif post_type == 'resolve':
            ISBN = request.POST.get('ISBN')
            cursor = connection.cursor()
            ret = cursor.callfunc("ACCEPT_BORROW_REQUEST", int, [customerID, ISBN, datetime.datetime.now()])
            if ret == 0:
                messages.success(request, 'Customer can now have the book')

            elif ret == 1:
                messages.error(request, 'Not a valid subscriber')

            elif ret == 2:
                messages.error(request, 'Quota limit crossed for this customer')

            elif ret == 3:
                messages.error(request, 'Book not available')

            elif ret == 4:
                messages.error(request, 'Already borrowed')


        elif post_type == 'decline':
            ISBN = request.POST.get('ISBN')
            cursor = connection.cursor()
            sql =   """
                DELETE FROM REQUESTS WHERE CUSTOMER_ID = %s AND ISBN = %s
                """
            cursor.execute(sql, [customerID, ISBN])
            cursor.close()

        elif post_type == 'received-expired-book':
            expiredID = request.POST.get('expiredID')
            cursor = connection.cursor()
            sql =   """
                DELETE FROM EXPIRED WHERE EXPIRED_ID = %s
                """
            cursor.execute(sql, [expiredID])
            cursor.close()


        return redirect('admin-borrows-view')

class AdminPlanListView(View):
    @check_if_authorized_manager
    def get(self, request):
        cursor = connection.cursor()
        cursor.callproc("REMOVE_EXPIRED_SUBSCRIBERS", [datetime.datetime.now()])
        cursor.close()

        cursor = connection.cursor()
        sql =   """
            SELECT P.PLAN_ID, P.NAME, P.PERIOD, P.BORROW_LIMIT, P.PRICE, (SELECT COUNT(*) FROM SUBSCRIBERS S WHERE S.PLAN_ID = P.PLAN_ID)
            FROM PLANS P
            """
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()

        planInfo = []
        for r in result:
            planInfo.append({
                "planID" : r[0],
                "planName" : r[1],
                "period" : r[2],
                "borrowLimit" : r[3],
                "price" : r[4],
                "activeSubscriptionCount" : r[5],
            })

        context = {
            "planInfo" : planInfo,
        }

        return render(request, 'admin_panel_plan_list.html', context)

    @check_if_authorized_manager
    def post(self, request):
        cursor = connection.cursor()
        cursor.callproc("REMOVE_EXPIRED_SUBSCRIBERS", [datetime.datetime.now()])
        cursor.close()

        print(request.POST)

        post_type = request.POST.get('post_type')


        if post_type == "delete":
            planID = int(request.POST.get('planID'))
            cursor = connection.cursor()
            sql =   """
                SELECT COUNT(*) FROM SUBSCRIBERS WHERE PLAN_ID = %s
                """
            cursor.execute(sql, [planID])
            result = cursor.fetchall()
            cursor.close()

            if int(result[0][0]) != 0:
                messages.error(request, 'Cannot delete a plan that has some subscriptions')
                return redirect('admin-plan-list-view')

            cursor = connection.cursor()
            sql =   """
                DELETE FROM PLANS WHERE PLAN_ID =%s
                """
            cursor.execute(sql, [planID])
            cursor.close()
            messages.success(request, 'Successfully deleted')

        elif post_type == 'edit':
            try:
                planID = int(request.POST.get('planID'))
                planName = request.POST.get('planName')
                period = int(request.POST.get('period'))
                borrowLimit = int(request.POST.get('borrowLimit'))
                price = float(request.POST.get('price'))

                if len(planName) == 0:
                    raise ValueError
            except ValueError:
                messages.error(request, 'Fill in the form correctly')
                return redirect('admin-plan-list-view')

            cursor = connection.cursor()
            sql =   """
                UPDATE PLANS SET NAME = %s, PERIOD = %s, BORROW_LIMIT = %s, PRICE = %s
                WHERE PLAN_ID = %s
                """
            cursor.execute(sql, [planName, period, borrowLimit, price, planID])
            cursor.close()
            messages.success(request, 'Updated Successfully')

        elif post_type == 'add':
            try:
                planName = request.POST.get('planName')
                period = int(request.POST.get('period'))
                borrowLimit = int(request.POST.get('borrowLimit'))
                price = float(request.POST.get('price'))

                if len(planName) == 0:
                    raise ValueError
            except ValueError:
                messages.error(request, 'Fill in the form correctly')
                return redirect('admin-plan-list-view')

            cursor = connection.cursor()
            sql =   """
                INSERT INTO PLANS(NAME, PERIOD, BORROW_LIMIT, PRICE)
                VALUES(%s, %s, %s, %s)
                """
            cursor.execute(sql, [planName, period, borrowLimit, price])
            cursor.close()
            messages.success(request, 'Added Successfully')



        return redirect('admin-plan-list-view')


# class Test(View):
#     def get(self, request):
#         return render(request, 'test.html')
#     def post(self, request):
#         print(type(request.POST.getlist('sample[]')))
#         print(request.POST.getlist('sample[]'))
#         return render(request, 'test.html')
