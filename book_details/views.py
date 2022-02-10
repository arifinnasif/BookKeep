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
        self.authorName = entry[2]
        self.price = entry[4]
        self.type = ", ".join(genre)


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
            bookShortInfo.append(BookShortDetail(r, genre))
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

        usertype = request.session.get('usertype', default='guest')
        
        

        context = {
            "bookLongInfo": bookLongInfo,
            "bookShortInfo": bookShortInfo,
            "authorInfo": authorInfo,
            "userfullname": userfullname,
            "usertype": usertype,
            "feedback": user_feedback,
        }

        return render(request, 'book_details.html', context)

    
    
    def post(self, request, isbn):
        
        username = str(request.session['username'])
        try:
            rating = int(request.POST.get('rating'))
            review = str(request.POST.get('review'))
            if rating >=1 and rating <=5 and len(review) < 256:
                cursor = connection.cursor()
                # sql = """INSERT INTO REVIEWS (CUSTOMER_ID, ISBN, RATING, FEEDBACK)
                #         VALUES (%s, %s, %s, %s)"""
                # cursor.execute(sql, [username, str(isbn), rating, review])
                return_msg = cursor.var(str).var
                cursor.callproc("POST_REVIEW", [username, str(isbn), rating, review, return_msg])
                msg = return_msg.getvalue()   
                messages.success(request, msg)
                connection.commit()
                print(username, isbn, rating, review)
                connection.close()
        except:
            quantity = int(request.POST.get('quantity'))
            print(quantity)

        return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))
        

    

# def add_review(request, isbn):
    
#     # return redirect('add_review')
#     pass
