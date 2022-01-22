from django.shortcuts import render
from django.db import connection
import random

class BookAuthorModel:
    def __init__(self, bookName, authorName):
        self.bookName = bookName;
        self.authorName = authorName;


# Create your views here.
def show_homepage(request):
    cursor = connection.cursor()
    sql = "SELECT B.NAME, A.NAME FROM BOOKS B LEFT OUTER JOIN WRITES W USING(ISBN) JOIN AUTHORS A USING (AUTHOR_ID)"
    cursor.execute(sql)
    result = cursor.fetchall()
    cursor.close()



    books = []

    for r in result:
        books.append(BookAuthorModel(r[0], r[1]))

    random.shuffle(books)


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
        "userfullname" : userfullname,
        "usertype" : usertype,
        "books" : books,
    }

    return render(request, 'catalog.html', context)
