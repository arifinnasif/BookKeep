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

# class BookInfoModel:
#     def __init__(self, row):
#         self.ISBN           = row[0]
#         self.bookName       = row[1]
#         self.authorName     = row[2]
#         if row[3] is None:
#             self.edition        = ""
#         else:
#             self.edition        = row[3]
#         if row[4] is None:
#             self.releaseDate    = ""
#         else:
#             self.releaseDate    = row[4].strftime('%Y-%m-%d')
#         self.price          = row[5]
#         self.pageCount      = row[6]
#         self.quantity       = row[7]
#         self.publisherName  = row[8]
#
#         self.authorID       = row[9]
#         self.publisherID    = row[10]



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




# class Test(View):
#     def get(self, request):
#         return render(request, 'test.html')
#     def post(self, request):
#         print(type(request.POST.getlist('sample[]')))
#         print(request.POST.getlist('sample[]'))
#         return render(request, 'test.html')
