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
        authorID        = request.POST.get("authorID")
        edition         = request.POST.get("edition")
        releaseDate     = datetime.datetime.strptime(request.POST.get("releaseDate"), '%Y-%m-%d')
        try:
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
