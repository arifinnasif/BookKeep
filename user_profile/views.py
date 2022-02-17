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

class AccountInfo:
    def __init__(self, row):
        self.username = row[0]
        self.password = row[1]
        self.fullname = row[2]
        self.fulladdress = row[3]
        self.email = row[4]
        self.accountCreationDate = row[5].strftime("%d %B %Y")


class BookInTheCart:
    def __init__(self, entry):
        self.isbn = entry[0]
        self.bookName = entry[1]
        self.authorName = entry[2]
        self.quantity = entry[3]
        self.price = entry[4]

class BookOrderList:
    def __init__(self, entry):
        self.totalprice = 0
        self.oid = entry[0]
        self.isbn = entry[1]
        self.bookName = entry[2]
        self.unitprice = entry[3]
        self.quantity = entry[4]
        self.price = self.unitprice * self.quantity
        self.orderdate = entry[5].strftime("%d %B %Y")
        if entry[6] is None:
            self.deliverydate = ""
        else:
            self.deliverydate = entry[6].strftime("%d %B %Y")     


class MyCartView(View):
    def get(self, request, cid):

        userfullname = None
        if request.session.get('usertype') == 'customer':
            cursor = connection.cursor()
            sql = "SELECT NAME FROM CUSTOMERS WHERE CUSTOMER_ID = %s"
            cursor.execute(sql, [request.session.get('username', default='guest')])
            result = cursor.fetchall()
            cursor.close()
            userfullname = result[0][0]

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

        if len(result) == 0:
            messages.error(request, 'Your Cart is Empty!')
        
        user_cart = []
        for r in result:
            user_cart.append(BookInTheCart(r))

        username = request.session.get('username')
        usertype = request.session.get('usertype', default='guest')

        context = {
            "userfullname": userfullname,
            "username": username,
            "usertype": usertype,
            "cart": user_cart,
        }

        return render(request, 'user_profile_cart.html', context)

    def post(self, request, cid):
        username = str(request.session['username'])

        if request.POST.get('post_type') == 'edit' or request.POST.get('post_type') == 'add' :
            try:
                quantity = int(request.POST.get('quantity'))
                isbn = str(request.POST.get('isbn'))
                print(quantity, isbn)
            except ValueError:
                messages.error(
                    request, 'Something went wrong. Please try again!')
                return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))

            cursor = connection.cursor()
            sql = """SELECT COUNT(*) FROM BOOKS WHERE ISBN = %s"""
            cursor.execute(sql, [isbn])
            result = cursor.fetchall()
            result = result[0][0]
            if result == 0:
                messages.error(
                    request, 'Something went wrong. Please try again!')
                
            else:

                return_msg = cursor.var(str).var
                cursor.callproc("INSERT_UPDATE_CART", [
                                quantity, username, isbn, return_msg])
                msg = return_msg.getvalue()
                messages.info(request, msg)
                connection.commit()

                connection.close()

            return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))

        elif request.POST.get('post_type') == 'delete':
            try:
                isbn = str(request.POST.get('isbn'))
                print(isbn)
            except ValueError:
                messages.error(request, 'Something went wrong. Please try again!')
                return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))  

            cursor = connection.cursor()
            sql = """DELETE 
                    FROM CARTS
                    WHERE CUSTOMER_ID = %s AND ISBN = %s"""
            cursor.execute(sql, [username, isbn])
            messages.info(request, 'Item Deleted Successfully!')
            connection.close()
            return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))



class MyOrderView(View):
    def get(self, request, cid):

        cursor = connection.cursor()
        sql = """SELECT ORDER_ID, ISBN, B.NAME BOOK, OB.UNIT_PRICE, OB.QUANTITY, O.ORDERING_DATE, O.DELIVERY_DATE
                FROM ORDERS O
                LEFT OUTER JOIN ORDER_BOOK OB USING (ORDER_ID)
                LEFT OUTER JOIN BOOKS B USING (ISBN)
                WHERE O.CUSTOMER_ID = %s"""
        cursor.execute(sql, [cid])
        result = cursor.fetchall()

        completed_list = []
        pending_list = []
        if len(result) == 0:
            messages.error(request, 'You Haven\'t Ordered Any Book Yet!')
        else:
            for r in result:
                # print(r)
                if r[-1] is None:   # the order is still pending 
                    pending_list.append(BookOrderList(r))
                else:
                    completed_list.append(BookOrderList(r))
            
            if len(completed_list) == 0:
                messages.error(request, 'You Don\'t Have Any Completed Order!')
            if len(pending_list) == 0:
                messages.error(request, 'You Don\'t Have Any Pending Order!')

            completed_dict = {}
            pending_dict = {}
            for i in completed_list:
                if i.oid not in completed_dict.keys():
                    values = []
                    totalprice = float(i.price)
                    values.append(i)
                    completed_dict[i.oid] = [values, totalprice]
                else:
                    values = completed_dict[i.oid][0]
                    # print(values)
                    totalprice = completed_dict[i.oid][1]
                    totalprice = totalprice + float(i.price)
                    values.append(i)
                    completed_dict[i.oid] = [values,totalprice]
            
            for i in pending_list:
                if i.oid not in pending_dict.keys():
                    values = []
                    totalprice = float(i.price)
                    values.append(i)
                    pending_dict[i.oid] = [values, totalprice]
                else:
                    values = pending_dict[i.oid][0]
                    totalprice = pending_dict[i.oid][1]
                    totalprice = totalprice + float(i.price)
                    values.append(i)
                    pending_dict[i.oid] = [values,totalprice]

        
        userfullname = None
        if request.session.get('usertype') == 'customer':
            cursor = connection.cursor()
            sql = "SELECT NAME FROM CUSTOMERS WHERE CUSTOMER_ID = %s"
            cursor.execute(sql, [request.session.get('username', default='guest')])
            result = cursor.fetchall()
            cursor.close()
            userfullname = result[0][0]

        username = request.session.get('username')
        usertype = request.session.get('usertype')
        context = {
            "userfullname": userfullname,
            "username": username,
            "usertype": usertype,
            "completed": completed_dict,
            "pending": pending_dict,
        }
        
        return render(request, 'user_profile_orders.html', context)

class MyAccountView(View):
    def get(self, request, cid):

        cursor = connection.cursor()
        sql = """SELECT *
                FROM CUSTOMERS C 
                WHERE CUSTOMER_ID = %s"""
        cursor.execute(sql, [cid])
        result = cursor.fetchall()
        cursor.close()
        print(result)

        accountInfo = []
        if len(result) == 0:
            messages.error("Something Went Wrong. This Account Doesn't Exist!")
        else:
            for r in result:
                accountInfo.append(AccountInfo(r))

        

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
            "accountInfo": accountInfo,
        }

        return render(request, 'user_profile_account.html', context)

        