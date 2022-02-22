from django.db import connection
from django.shortcuts import render, redirect
from django.contrib import messages
from django.views import View
import datetime
from django.http import HttpResponseRedirect

# Create your views here.


class BookShortDetail:
    def __init__(self, entry, genre):
        self.bookName = entry[0]
        self.isbn = entry[1]
        self.authorName = entry[2]
        self.price = entry[4]
        self.quantity = entry[7]
        self.type = ", ".join(genre)

        if entry[9] is not None:
            self.discountedprice = entry[9]
        else:
            self.discountedprice = None
        if entry[10] is not None:
            self.offername = entry[10]
        else:
            self.offername = None



class BookLongDetail:
    def __init__(self, entry, genre):
        self.bookName = entry[0]
        self.isbn = entry[1]
        self.authorName = entry[2]
        if entry[3] is None:
            self.edition = "! Information Not Found !"
        else:
            self.edition = entry[3]
        self.price = entry[4]
        if entry[5] is None:
            self.pages = "! Information Not Found !"
        else:
            self.pages = entry[5]
        if entry[6] is None:
            self.releaseDate = "! Information Not Found! "
        else:
            self.releaseDate = entry[6].strftime("%d %B %Y")
        self.quantity = entry[7]
        self.publisher = entry[8]
        self.type = ", ".join(genre)


class AuthorDetail:
    def __init__(self, row):
        self.name = row[0]
        if row[1] is None:
            self.dob = "! Information Not Found !"
        else:
            self.dob = row[1].strftime("%d %B %Y")
        if row[2] is None:
            self.dod = ""
        else:
            self.dod = row[2].strftime("%d %B %Y")
        if row[3] is None:
            self.about = "! Information Not Found !"
        else:
            self.about = row[3]

class UserReview:
    def __init__(self, row):
        self.flag = True
        if row[0] is None:
            self.flag = False
        else:
            self.username = row[0]
        self.rating = row[3]
        if row[4] is None:
            self.review = ""
        else:
            self.review = row[4]


class UserBookDetailsView(View):
    def get(self, request, isbn):

        ####### OFFER CHECK #########
        cursor = connection.cursor()
        sql =   """
                SELECT OFFER_ID, NAME, DISCOUNT_PCT, START_DATE, PERIOD
                FROM OFFERS
                """
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()

        ongoingOfferInfo = []
        for r in result:
            cursor = connection.cursor()
            sql =   """
                    SELECT ISBN
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
                "discount_pct" : r[2],
                "start_date" : r[3].strftime('%Y-%m-%d'),
                "period" : r[4],
                "books_with_this_offer" : books_with_this_offer,
            }

            if r[3] < datetime.datetime.now() and r[3]+datetime.timedelta(days = int(r[4])) > datetime.datetime.now():
                ongoingOfferInfo.append(temp_dict)
                # messages.info(request, temp_dict['offerName'] + ' Ongoing')
        print(ongoingOfferInfo)

        #############################


        cursor = connection.cursor()
        sql_book = """SELECT B.NAME, ISBN, A.NAME AUTHOR, B.EDITION, B.PRICE, B.PAGE_COUNT, B.RELEASE_DATE, B.QUANTITY, P.NAME PUBLISHER
                FROM BOOKS B
                LEFT OUTER JOIN WRITES USING (ISBN)
                LEFT OUTER JOIN AUTHORS A USING (AUTHOR_ID)
                LEFT OUTER JOIN PUBLISHERS P USING (PUBLISHER_ID)
                WHERE ISBN = %s"""
        cursor.execute(sql_book, [isbn])
        result = cursor.fetchall()


        sql_genre = """SELECT B_TYPE
                FROM BOOKS B
                LEFT OUTER JOIN BOOK_TYPE BT USING (ISBN)
                WHERE ISBN = %s"""
        cursor.execute(sql_genre, [isbn])
        type = cursor.fetchall()

        sql_author = """SELECT A.NAME, A.DOB, A.DOD, A.ABOUT
                        FROM BOOKS B
                        LEFT OUTER JOIN WRITES W USING (ISBN)
                        LEFT OUTER JOIN AUTHORS A USING (AUTHOR_ID)
                        WHERE ISBN = %s"""
        cursor.execute(sql_author, [isbn])
        author_detail = cursor.fetchall()


        genre = []
        for g in type:
            if g is None:
                g = "Not Found"
            else:
                g = ''.join(g)
                genre.append(g)

        # print(genre)

        bookLongInfo = []
        for r in result:
            bookLongInfo.append(BookLongDetail(r, genre))
        # bookLongInfo.add_genre(genre)

        bookShortInfo = []
        for r in result:
            val = [i for i in r]
            for j in ongoingOfferInfo:
                if val[1] in j['books_with_this_offer']:
                    # per book discount
                    discount = float(val[4]) * float(j['discount_pct'])
                    # discounted price per book
                    val.append("{:.2f}".format(round((float(val[4]) - discount), 2)))
                    val.append(j['offerName'])
                else:
                    val.append(None)  # same price as before
                    val.append(None)
            bookShortInfo.append(BookShortDetail(val, genre))
        # bookShortInfo.add_genre(genre)

        authorInfo = []
        for r in author_detail:
            authorInfo.append(AuthorDetail(r))

        # userfullname = None


        sql = """SELECT C.NAME, CUSTOMER_ID, R.ISBN, R.RATING, R.FEEDBACK
                 FROM CUSTOMERS C
                 LEFT OUTER JOIN REVIEWS R USING (CUSTOMER_ID)
                 WHERE R.ISBN = %s"""
        cursor.execute(sql, [isbn]) # request.session.get('username', default='guest')
        result = cursor.fetchall()
        cursor.close()
        print(result)

        user_feedback = []
        for r in result:
            user_feedback.append(UserReview(r))


        userfullname = None
        if request.session.get('usertype') == 'customer':
            cursor = connection.cursor()
            sql = "SELECT NAME FROM CUSTOMERS WHERE CUSTOMER_ID = %s"
            cursor.execute(sql, [request.session.get('username', default='guest')])
            result = cursor.fetchall()
            cursor.close()
            userfullname = result[0][0]

        username = request.session.get('username')
        usertype = request.session.get('usertype', default='guest')

        cursor = connection.cursor()
        cursor.callproc("REMOVE_EXPIRED_SUBSCRIBERS", [datetime.datetime.now()])
        cursor.close()

        isSubscriber = False
        isRequestable = False

        if usertype != "guest" and username is not None and len(username) != 0:
            cursor = connection.cursor()
            sql = """SELECT COUNT(*) FROM SUBSCRIBERS WHERE CUSTOMER_ID = %s"""
            cursor.execute(sql,[username])
            result = cursor.fetchall()
            cursor.close()

            if int(result[0][0]) != 0:
                isSubscriber = True

        if isSubscriber:
            isRequestable = True
            cursor = connection.cursor()
            sql = """
                SELECT COUNT(*)
                FROM REQUESTS
                WHERE CUSTOMER_ID = %s
                AND ISBN = %s
                """
            cursor.execute(sql,[username, str(isbn)])
            result = cursor.fetchall()
            cursor.close()

            cnt_books_in_requests = int(result[0][0])

            cursor = connection.cursor()
            sql = """
                SELECT COUNT(*)
                FROM BORROWABLE_ITEMS
                WHERE ISBN = %s
                AND BORROWABLE_ITEM_ID IN (
                    SELECT BORROWABLE_ITEM_ID FROM BORROWS WHERE CUSTOMER_ID = %s
                    )
                """
            cursor.execute(sql,[str(isbn), username])
            result = cursor.fetchall()
            cursor.close()

            cnt_books_in_borrows = int(result[0][0])

            if cnt_books_in_requests != 0 or cnt_books_in_borrows != 0:
                isRequestable = False

        rating = "Not Rated"
        cursor = connection.cursor()
        sql = "SELECT AVG(RATING) FROM REVIEWS WHERE ISBN = %s"
        cursor.execute(sql, [str(isbn)])
        result = cursor.fetchall()
        cursor.close()
        if result[0][0] is not None:
            rating = ('%.1f' % result[0][0])+"/5.0"


        context = {
            "bookLongInfo": bookLongInfo,
            "bookShortInfo": bookShortInfo,
            "authorInfo": authorInfo,
            "username": username,
            "userfullname": userfullname,
            "usertype": usertype,
            "feedback": user_feedback,
            "isSubscriber" : isSubscriber, # dont show any request button if isSubscriber is False
            "isRequestable" : isRequestable, # disable request button if isSubscriber is True and isRequestable is False
            "rating" : rating,
        }

        return render(request, 'book_details.html', context)



    def post(self, request, isbn):

        username = str(request.session['username'])
        try:
            rating = int(request.POST.get('rating'))
            review = str(request.POST.get('review'))
            if rating >=1 and rating <=5 and len(review) < 256:
                cursor = connection.cursor()
                return_msg = cursor.var(str).var
                cursor.callproc("POST_REVIEW", [username, str(isbn), rating, review, return_msg])
                msg = return_msg.getvalue()
                messages.info(request, msg)
                connection.commit()
                print(username, isbn, rating, review)
                connection.close()
        except:
            quantity = int(request.POST.get('quantity'))
            print(quantity)

        ### check if the post is of request type
        is_request = False
        if is_request:
            cursor = connection.cursor()
            ret = cursor.callfunc("REQUEST_TO_BORROW", [username, str(isbn), datetime.datetime.now()])
            cursor.close()

            if ret == 0:
                # success
                messages.success(request, "Successfully requested!")
            elif ret == 1:
                # not a sub
                messages.error(request, "You are not a subscriber or your subscription has expired")
            elif ret == 2:
                # already requested (pending)
                messages.warning(request, "Your request is pending. Request not made")
            elif ret ==3:
                # already borrowed
                messages.error(request, "You have already borrowed this book")


        return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))
