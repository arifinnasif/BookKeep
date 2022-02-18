from django.shortcuts import render, redirect, HttpResponseRedirect
from django.db import connection
from django.views import View
from django.contrib import messages
import datetime

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
    def __init__(self, row, contact):
        self.username = row[0]
        self.password = row[1]
        self.fullname = row[2]
        self.fulladdress = row[3]
        self.email = row[4]
        self.accountCreationDate = row[5].strftime("%d %B %Y")
        self.contact = contact


class BookInTheCart:
    def __init__(self, entry):
        self.isbn = entry[0]
        self.bookName = entry[1]
        self.authorName = entry[2]
        self.quantity = entry[3]
        self.price = entry[4]
        self.discounted_price = entry[5]


class CheckoutCart:
    def __init__(self, subtotal, total):
        self.subtotal = "{:.2f}".format(round(subtotal, 2))
        self.deliveryfee = "50.00"
        self.total = "{:.2f}".format(round(total + float(self.deliveryfee), 2))
        self.discount = "{:.2f}".format(round(subtotal-total, 2))



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

        ####### OFFER CHECK #########

        cursor = connection.cursor()
        sql =   """
                SELECT OFFER_ID, NAME, DISCOUNT_PCT, START_DATE, PERIOD
                FROM OFFERS
                """
        cursor.execute(sql)
        result = cursor.fetchall()
        cursor.close()

        ongoingOfferInfo = []
        for r in result:
            cursor = connection.cursor()
            sql =   """
                    SELECT ISBN
                    FROM OFFER_BOOK OB INNER JOIN BOOKS B USING (ISBN)
                    WHERE OB.OFFER_ID = %s
                    """
            cursor.execute(sql,[int(r[0])])
            result2 = cursor.fetchall()
            cursor.close()

            books_with_this_offer = []
            for r2 in result2:
                books_with_this_offer.append(r2[0])

            temp_dict = {
                "offerID" : r[0],
                "offerName" : r[1],
                "discount_pct" : r[2],
                "start_date" : r[3].strftime('%Y-%m-%d'),
                "period" : r[4],
                "books_with_this_offer" : books_with_this_offer,
            }

            if r[3] < datetime.datetime.now() and r[3]+datetime.timedelta(days = int(r[4])) > datetime.datetime.now():
                ongoingOfferInfo.append(temp_dict)
        # print(ongoingOfferInfo)


        ####### BOOK FETCH #########

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
        checkout_cart = []
        subtotal = 0
        total = 0

        for r in result:
            val = [i for i in r]
            print(val)
            for j in ongoingOfferInfo:
                if val[0] in j['books_with_this_offer']:
                    # per book discount
                    discount = float(val[4]) * float(j['discount_pct']) 
                    # discounted price per book
                    val.append("{:.2f}".format(round((float(val[4]) - discount), 2)))
                else:
                    discount = 0.00
                    val.append(val[4])  # same price as before
            
            price = float(val[4])*int(val[3])
            discount = discount*int(val[3])
            subtotal = subtotal + price
            total = total + (price - discount)

            user_cart.append(BookInTheCart(val))

        # print(user_cart)
        checkout_cart.append(CheckoutCart(subtotal, total))

        
        

        username = request.session.get('username')
        usertype = request.session.get('usertype', default='guest')

        context = {
            "userfullname": userfullname,
            "username": username,
            "usertype": usertype,
            "cart": user_cart,
            "checkout": checkout_cart,
            "offerInfo": ongoingOfferInfo,
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
        completed_dict = {}
        pending_dict = {}
        
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
        # print(result)
        
        cursor = connection.cursor()
        sql = """SELECT CONTACT_NUMBER
                FROM CUSTOMER_CONTACT_NUMBER 
                WHERE CUSTOMER_ID = %s"""
        cursor.execute(sql, [cid])
        result_2 = cursor.fetchall()
        # print(result_2)
        cursor.close()

        accountInfo = []
        if len(result) == 0:
            messages.error("Something Went Wrong. This Account Doesn't Exist!")
        else:
            contact_no = []
            if len(result_2)==0:
                contact_no.append("Not Provided!")
            else:
                for r in result_2:
                    contact_no.append(r[0])
            for info in result:
                accountInfo.append(AccountInfo(info, contact_no))

        

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

        