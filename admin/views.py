from django.shortcuts import render
from django.db import connection
from django.views import View

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
            self.releaseDate    = row[4].strftime('%Y-%m-%d %H:%M:%S')
        self.price          = row[5]
        self.pageCount      = row[6]
        self.quantity       = row[7]
        self.publisherName  = row[8]

class AdminBookListView(View):
    def get(self, request):
        cursor = connection.cursor()
        sql = """SELECT ISBN, B.NAME, A.NAME, B.EDITION, B.RELEASE_DATE, B.PRICE, B.PAGE_COUNT, B.QUANTITY, P.NAME
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

        context = {
            "bookInfo" : bookInfo,
        }

        return render(request, 'admin_panel_book_list.html', context)
