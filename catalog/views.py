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

    context = {
        "books" : books,
    }
    return render(request, 'catalog.html', context)
