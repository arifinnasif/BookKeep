from django.db import connection
from django.shortcuts import render
from django.views import View

# Create your views here.

# def show_books(request, isbn):
#     context = {
#         "isbn": isbn
#     }
#     return render (request, 'book_details.html', context)

class BookShortDetail:
    def __init__(self, entry):
        self.bookName       = entry[0]
        self.authorName     = entry[1]
        self.price          = entry[2]

class BookDetailsView(View):
    def get(self, request, isbn):
        cursor = connection.cursor()
        sql = """SELECT B.NAME, A.NAME AUTHOR, B.PRICE
                FROM BOOKS B 
                LEFT OUTER JOIN WRITES USING (ISBN)
                LEFT OUTER JOIN AUTHORS A USING (AUTHOR_ID)
                WHERE ISBN = %s"""
        cursor.execute(sql, [isbn])
        result = cursor.fetchall()
        cursor.close()

        bookInfo = []
        for r in result:
            bookInfo.append(BookShortDetail(r))
            
        # print(bookInfo[0].bookName)

        context = {
            "bookInfo" : bookInfo,
        }

        return render (request, 'book_details.html', context)

