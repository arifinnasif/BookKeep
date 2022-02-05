from django.shortcuts import render, redirect
from django.db import connection
from django.views import View
from BookKeep.settings import BASE_DIR
from django.contrib import messages
import datetime
import os

import datetime


# Create your views here.

def show_admin(request):
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
        self.accountCreatedOn   = row[4].strftime('%y-%m-%d %H:%M:%S')
        if row[6] is None:
            self.planName       = ""
            self.membershipBoughtOn = ""
        else:
            self.planName       = row[6]
            self.membershipBoughtOn = row[5].strftime('%y-%m-%d %H:%M:%S')



class AdminCustomerListView(View):
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

class BookInfoModel:
    def __init__(self, row):
        self.ISBN           = row[0]
        self.bookName       = row[1]
        self.authorName     = row[2]
        if row[3] is None:
            self.edition        = ""
        else:
            self.edition        = row[3]
        if row[4] is None:
            self.releaseDate    = ""
        else:
            self.releaseDate    = row[4].strftime('%Y-%m-%d')
        self.price          = row[5]
        self.pageCount      = row[6]
        self.quantity       = row[7]
        self.publisherName  = row[8]

        self.authorID       = row[9]
        self.publisherID    = row[10]



class AdminBookListView(View):
    def get(self, request):
        cursor = connection.cursor()
        sql = """SELECT ISBN, B.NAME, A.NAME, B.EDITION, B.RELEASE_DATE, B.PRICE, B.PAGE_COUNT, B.QUANTITY, P.NAME, AUTHOR_ID, PUBLISHER_ID
                FROM BOOKS B
                LEFT OUTER JOIN WRITES USING (ISBN)
                LEFT OUTER JOIN AUTHORS A USING (AUTHOR_ID)
                LEFT OUTER JOIN PUBLISHERS P USING (PUBLISHER_ID)"""
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()



        bookInfo = []
        for r in result:
            bookInfo.append(BookInfoModel(r))

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

        context = {
            "bookInfo" : bookInfo,
            "authorList" : authorList,
            "publisherList" : publisherList,
        }

        return render(request, 'admin_panel_book_list.html', context)

    def post(self, request):
        post_type       = request.POST.get("post_type")
        isbn            = request.POST.get("ISBN")
        bookName        = request.POST.get("bookName")
        edition         = request.POST.get("edition")
        releaseDate     = datetime.datetime.strptime(request.POST.get("releaseDate"), '%Y-%m-%d')
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
            print(isbn)
            print("dakr side")
            print(edition)
            cursor.callproc("INSERT_BOOK_INFO",
                                [isbn, bookName, authorID, edition, releaseDate, price, pageCount, quantity, publisherID,])
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

    def post(self, request):
        # print(request.POST.get("post_type"))
        post_type = request.POST.get("post_type")

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
            sql =   """
                    INSERT INTO AUTHORS (
                        NAME,
                        DOB,
                        DOD,
                        ABOUT
                        )
                    VALUES (%s, TO_DATE(%s, 'yyyy-mm-dd'), TO_DATE(%s, 'yyyy-mm-dd'), %s)
                    """
            cursor.execute(sql, [authorName, DOB, DOD, about])
            cursor.close()
            messages.success(request, "Successfully added")

        return redirect('admin-author-list-view')
