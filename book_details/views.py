from django.db import connection
from django.shortcuts import render
from django.views import View
import datetime

# Create your views here.

# def show_books(request, isbn):
#     context = {
#         "isbn": isbn
#     }
#     return render (request, 'book_details.html', context)


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

        cursor.close()

        genre = []
        for g in type:
            if g is None:
                g = "Not Found"
            else:
                g = ''.join(g)
                genre.append(g)

        print(genre)

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

        context = {
            "bookLongInfo": bookLongInfo,
            "bookShortInfo": bookShortInfo,
            "authorInfo": authorInfo,
        }

        return render(request, 'book_details.html', context)
