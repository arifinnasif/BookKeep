from multiprocessing.sharedctypes import Value
from django.shortcuts import render, redirect, HttpResponseRedirect
from django.db import connection
from django.views import View
from django.contrib import messages


# Create your views here.

def show_profile(request, cid):

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
        "userfullname": userfullname,
        "username": username,
        "usertype": usertype,
    }

    return render(request, 'user_profile.html', context)



class BookInTheCart:
    def __init__(self, entry):
        self.isbn = entry[0]
        self.bookName = entry[1]
        self.authorName = entry[2]
        self.quantity = entry[3]
        self.price = entry[4]



class MyCartView(View):
    def get(self, request, cid):

        cursor = connection.cursor()
        sql = """SELECT ISBN, B.NAME BOOK, A.NAME AUTHOR, C.QUANTITY, B.PRICE
                FROM CARTS C 
                LEFT OUTER JOIN BOOKS B USING (ISBN)
                LEFT OUTER JOIN WRITES W USING (ISBN)
                LEFT OUTER JOIN AUTHORS A USING (AUTHOR_ID)
                WHERE C.CUSTOMER_ID = %s"""
        cursor.execute(sql, [cid])
        result = cursor.fetchall()
        cursor.close()

        user_cart = []
        for r in result:
            # print(r)
            user_cart.append(BookInTheCart(r))


        username = request.session.get('username')
        usertype = request.session.get('usertype', default='guest')

        context = {
            "username": username,
            "usertype": usertype,
            "cart": user_cart,
        }

        return render(request, 'user_profile_cart.html', context)

    def post (self, request, cid):
        username = str(request.session['username'])
        try:
            quantity = int(request.POST.get('quantity'))
            isbn = str(request.POST.get('isbn'))
            print(quantity, isbn)
        except ValueError:
            messages.error(request, 'Something went wrong. Please try again!')
            return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))
        


        cursor = connection.cursor()
        sql = """UPDATE CARTS 
                SET QUANTITY = %s
                WHERE CUSTOMER_ID = %s AND ISBN = %s"""
        cursor.execute(sql, [quantity, username, isbn])
         
        messages.success(request, 'Cart edited successfully!')
        connection.commit()
            
        connection.close()
    
        return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))


