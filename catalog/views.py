from django.shortcuts import render
from django.db import connection
import random, datetime
from django.contrib import messages
from django.views import View

class BookAuthorModel:
    def __init__(self, bookName, price, authorName, isbn, discountedprice, offername):
        self.bookName = bookName
        self.price = price
        self.authorName = authorName
        self.isbn = isbn
        self.discountedprice = discountedprice
        self.offername = offername


# Create your views here.
class HomepageView(View):

    def get(self, request):

        ####### OFFER CHECK #########
        cursor = connection.cursor()
        sql =   """
                SELECT OFFER_ID, NAME, DISCOUNT_PCT, START_DATE, PERIOD, (START_DATE + PERIOD) END_DATE
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
                "end_date" : r[5].strftime('%Y-%m-%d'),
                "books_with_this_offer" : books_with_this_offer,
            }

            if r[3] < datetime.datetime.now() and r[3]+datetime.timedelta(days = int(r[4])) > datetime.datetime.now():
                ongoingOfferInfo.append(temp_dict)
                messages.info(request, temp_dict['offerName'] + ' Ongoing! Offer Ends on ' + temp_dict['end_date'] + '. Hurry Up!')
        print(ongoingOfferInfo)    
            
        
        cursor = connection.cursor()
        # adding ISBN to the query
        sql = "SELECT B.NAME BOOK_NAME, B.PRICE PRICE, A.NAME WRITER_NAME, ISBN FROM BOOKS B LEFT OUTER JOIN WRITES W USING(ISBN) JOIN AUTHORS A USING (AUTHOR_ID)"
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()



        books = []

        for r in result:
            val = [i for i in r]
            for j in ongoingOfferInfo:
                    if val[3] in j['books_with_this_offer']:
                        # per book discount
                        discount = float(val[1]) * float(j['discount_pct']) 
                        # discounted price per book
                        val.append("{:.2f}".format(round((float(val[1]) - discount), 2)))
                        val.append(j['offerName'])
                    else:
                        val.append(None)  # same price as before
                        val.append(None)
            books.append(BookAuthorModel(val[0], val[1], val[2], val[3], val[4], val[5]))

        random.shuffle(books)


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

        context = {
            "username": username,
            "userfullname" : userfullname,
            "usertype" : usertype,
            "books" : books,
        }

        return render(request, 'catalog.html', context)

    def post(self, request):
        
        ####### OFFER CHECK #########
        cursor = connection.cursor()
        sql =   """
                SELECT OFFER_ID, NAME, DISCOUNT_PCT, START_DATE, PERIOD, (START_DATE + PERIOD) END_DATE
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
                "end_date" : r[5].strftime('%Y-%m-%d'),
                "books_with_this_offer" : books_with_this_offer,
            }

            if r[3] < datetime.datetime.now() and r[3]+datetime.timedelta(days = int(r[4])) > datetime.datetime.now():
                ongoingOfferInfo.append(temp_dict)
                messages.info(request, temp_dict['offerName'] + ' Ongoing! Offer Ends on ' + temp_dict['end_date'] + '. Hurry Up!')
        # print(ongoingOfferInfo)
        
        #############################

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

        ###############################

        try:
            expr = str(request.POST.get('search'))
            
            cursor = connection.cursor()
           

            sql = """ SELECT B.NAME BOOK_NAME, B.PRICE PRICE, A.NAME WRITER_NAME, ISBN FROM BOOKS B 
                    LEFT OUTER JOIN WRITES W USING(ISBN) 
                    JOIN AUTHORS A USING (AUTHOR_ID)
                    WHERE LOWER(B.NAME) LIKE %s
                    OR LOWER(A.NAME) LIKE %s"""
            
            cursor.execute(sql, ['%' + str(expr.lower()) + '%', '%' + str(expr.lower()) + '%'])
            print(expr)
            result = cursor.fetchall()
            cursor.close()
        except Exception as e:
            print(e)
            messages.error(request, 'Error while searching! Please try again.')


        books = []
        for r in result:
            val = [i for i in r]
            for j in ongoingOfferInfo:
                    if val[3] in j['books_with_this_offer']:
                        # per book discount
                        discount = float(val[1]) * float(j['discount_pct']) 
                        # discounted price per book
                        val.append("{:.2f}".format(round((float(val[1]) - discount), 2)))
                        val.append(j['offerName'])
                    else:
                        val.append(None)  # same price as before
                        val.append(None)
            books.append(BookAuthorModel(val[0], val[1], val[2], val[3], val[4], val[5]))

        random.shuffle(books)

        context = {
            "username": username,
            "userfullname" : userfullname,
            "usertype" : usertype,
            "books" : books,
        }
        return render(request, 'catalog.html', context)
