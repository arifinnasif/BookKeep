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


class PlanInfo:
    def __init__(self, row):
        self.id = row[0]
        self.name = row[1]
        self.period = row[2]
        self.borrow_limit = row[3]
        self.price = row[4]


class BookInTheCart:
    def __init__(self, entry):
        self.isbn = entry[0]
        self.bookName = entry[1]
        self.authorName = entry[2]
        self.quantity = entry[3]
        self.price = entry[4]
        self.discounted_price = entry[5]


class BookInTheWishlist:
    def __init__(self, entry):
        self.isbn = entry[0]
        self.bookName = entry[1]
        self.authorName = entry[2]
        self.price = entry[3]
        self.discounted_price = entry[4]



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


class MyWishListView(View):
    def get(self, request, cid):

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
        
        cursor = connection.cursor()
        sql = """SELECT ISBN, B.NAME BOOK, A.NAME AUTHOR, B.PRICE
                FROM WISHLISTS W
                LEFT OUTER JOIN BOOKS B USING (ISBN)
                LEFT OUTER JOIN WRITES W USING (ISBN)
                LEFT OUTER JOIN AUTHORS A USING (AUTHOR_ID)
                WHERE W.CUSTOMER_ID = %s"""
        cursor.execute(sql, [cid])
        result = cursor.fetchall()
        cursor.close()

        if len(result) == 0:
            messages.error(request, 'Your Wishlist is Empty!')

        user_wishlist = []
        for r in result:
            val = [i for i in r]
            # print(val)
            for j in ongoingOfferInfo:
                if val[0] in j['books_with_this_offer']:
                    # per book discount
                    discount = float(val[3]) * float(j['discount_pct']) 
                    # discounted price per book
                    val.append("{:.2f}".format(round((float(val[3]) - discount), 2)))
                else:
                    discount = 0.00
                    val.append(val[3])  # same price as before
            
            # price = float(val[4])*int(val[3])
            # discount = discount*int(val[3])

            user_wishlist.append(BookInTheWishlist(val))


        
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
            "wishlist": user_wishlist,
        }
        
        return render(request, 'user_profile_wishlist.html', context)

    
    def post(self, request, cid):
        username = str(request.session['username'])

        if request.POST.get('post_type') == 'add' :
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

                cursor = connection.cursor()
                sql = """DELETE 
                        FROM WISHLISTS
                        WHERE CUSTOMER_ID = %s AND ISBN = %s"""
                cursor.execute(sql, [username, isbn])
                connection.close()

            return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))

        
        elif request.POST.get('post_type') == 'remove':
            try:
                isbn = str(request.POST.get('isbn'))
                # print(isbn)
            except ValueError:
                messages.error(request, 'Something went wrong. Please try again!')
                return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))  

            cursor = connection.cursor()
            sql = """DELETE 
                    FROM WISHLISTS
                    WHERE CUSTOMER_ID = %s AND ISBN = %s"""
            cursor.execute(sql, [username, isbn])
            messages.info(request, 'Item Removed Successfully!')
            connection.close()
            return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))

        
        elif request.POST.get('post_type') == 'wish' :
            try:
                isbn = str(request.POST.get('isbn'))
                print(isbn)
            except ValueError:
                messages.error(
                    request, 'Something went wrong. Please try again!')
                return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))

            cursor = connection.cursor()
            sql = """SELECT COUNT(*) FROM WISHLISTS WHERE CUSTOMER_ID = %s AND ISBN = %s"""
            cursor.execute(sql, [username, isbn])
            result = cursor.fetchall()
            result = result[0][0]
            if result != 0:
                messages.error(
                    request, 'You Have Already Wishlisted This!')
                
            else:

                cursor = connection.cursor()
                sql = """INSERT 
                        INTO WISHLISTS (CUSTOMER_ID, ISBN) 
                        VALUES (%s, %s)"""
                cursor.execute(sql, [username, isbn])
                connection.close()
                messages.info(request, 'Book Wishlisted!')
                connection.commit()

            return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))

        


class MyCartView(View):
    def get(self, request, cid):

        userfullname = None
        if request.session.get('usertype') == 'customer':
            cursor = connection.cursor()
            sql = "SELECT NAME, ADDRESS FROM CUSTOMERS WHERE CUSTOMER_ID = %s"
            cursor.execute(sql, [request.session.get('username', default='guest')])
            result = cursor.fetchall()
            cursor.close()
            userfullname = result[0][0]
            useraddress = result[0][1]
            # print(useraddress)

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
            # print(val)
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
            "useraddress": useraddress,
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
                # print(isbn)
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

        elif request.POST.get('post_type') == 'order':
            try:
                # print(username)
                cursor = connection.cursor()
                # return_msg = cursor.var(int).var
                # cursor.callproc('CHECK_BOOK_STOCK', [username, return_msg])
                # flag = return_msg.getvalue()
                # print(flag)
                sql = """SELECT * FROM CARTS WHERE CUSTOMER_ID = %s"""
                cursor.execute(sql, [cid])
                result = cursor.fetchall()
                cursor.close()
                for r in result:
                    # print(r[2])
                    cursor = connection.cursor()
                    sql = """SELECT QUANTITY, NAME FROM BOOKS WHERE ISBN = %s"""

                    cursor.execute(sql,[r[1]])
                    result2 = cursor.fetchall()
                    stock = result2[0][0]
                    bookname = result2[0][1]
                    cursor.close()
                    # print(stock)
                    if int(stock) < int(r[2]):
                        messages.error(request, 'The Book  "' + str(bookname)+ '" is Out of Stock! Please Check Out the Available Quantity ')
                        return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))
                cursor = connection.cursor()
                cursor.callproc('MAKE_ORDER', [cid, datetime.datetime.now()])
                cursor.close()
                messages.info(request, 'Order Placed Successfully!')
            except Exception as e:
                print(e)
                messages.error(request, 'Could not complete placing order. Please try again!')
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
                LEFT OUTER JOIN SUBSCRIBERS S USING (CUSTOMER_ID)
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

        planInfo = []

        if(result[0][-1]):
            cursor = connection.cursor()
            sql = """SELECT *
                    FROM PLANS
                    WHERE PLAN_ID = %s"""
            cursor.execute(sql, [result[0][-1]])    
            result_3 = cursor.fetchall()
            cursor.close()   
            
            for r in result_3:
                planInfo.append(PlanInfo(r))

            # cursor = connection.cursor()
            # sql = """SELECT COUNT(*)
            #         FROM BORROWS
            #         WHERE CUSTOMER_ID = %s"""
            # cursor.execute(sql, [cid])
 
        else:
            cursor = connection.cursor()
            sql = """SELECT *
                    FROM PLANS
                    """
            cursor.execute(sql)    
            result_3 = cursor.fetchall()
            cursor.close()
            for r in result_3:
                planInfo.append(PlanInfo(r))


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
            "planInfo": planInfo,
        }

        return render(request, 'user_profile_account.html', context)

    
    def post(self, request, cid):
        username = str(request.session['username'])

        if request.POST.get('post-type') == 'buy-plan' :
            try:
                id = int(request.POST.get('planID'))
                print(id)
            except ValueError:
                messages.error(
                    request, 'Something went wrong. Please try again!')
                return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))

            cursor = connection.cursor()
            sql = """SELECT COUNT(*) FROM SUBSCRIBERS WHERE CUSTOMER_ID = %s"""
            cursor.execute(sql, [username])
            result = cursor.fetchall()
            print(result)
            cursor.close()
            if result == 0:
                messages.error(
                    request, 'You already have a current plan!')

            else:
                cursor = connection.cursor()
                sql = """INSERT INTO SUBSCRIBERS (CUSTOMER_ID, MEMBERSHIP_BOUGHT_ON, PLAN_ID)
                        VALUES(%s, %s, %s)"""
                
                cursor.execute(sql, [username, datetime.datetime.now(), id])
                messages.info(request, 'You have successfully bought a plan!')
                connection.commit()
                connection.close()

        return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))



class MyBorrowsView (View):
    def get(self, request, cid):
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

        return render(request, 'user_profile_borrows.html', context)




# class MySubscriptionView(View):
#     def get(self, request, cid):
#         userfullname = None
#         if request.session.get('usertype') == 'customer':
#             cursor = connection.cursor()
#             sql = "SELECT NAME FROM CUSTOMERS WHERE CUSTOMER_ID = %s"
#             cursor.execute(sql, [request.session.get('username', default='guest')])
#             result = cursor.fetchall()
#             cursor.close()
#             userfullname = result[0][0]

#         username = request.session.get('username')
#         usertype = request.session.get('usertype', default='guest')


#         context = {
#             "userfullname": userfullname,
#             "username": username,
#             "usertype": usertype,
#         }

#         return render(request, 'user_profile_subscription.html', context)