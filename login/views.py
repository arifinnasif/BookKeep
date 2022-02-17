from django.shortcuts import render, redirect
from django.db import connection
from django.views import View
from django.contrib import messages

from custom_utils import check_if_anonymous

import datetime


# Create your views here.
class CustomerLoginView(View):
    @check_if_anonymous
    def get(self, request):
        context = {
            'usertype' : 'Customer',
        }
        return render(request, "login.html", context)

    @check_if_anonymous
    def post(self, request):
        username = request.POST.get("username")
        password = request.POST.get("password")


        cursor = connection.cursor()
        sql = "SELECT PASSWORD FROM CUSTOMERS WHERE CUSTOMER_ID=%s"
        cursor.execute(sql, [username])
        result = cursor.fetchall()
        cursor.close()


        if len(result) > 0 and result[0][0] == password:
            print("[INFO] " + username + " LOGGED IN SUCCESSFULLY")
            request.session['username'] = username
            request.session['usertype'] = 'customer'
            # show toast
            return redirect('homepage')
        else:
            print("FAILED")
            # show toast
            messages.error(request, 'Username or Password incorrect')
            return redirect('customer-login-view')

class CustomerLogoutView(View):
    def get(self, request):
        request.session.flush()
        return redirect('homepage')


# def show_login_page(request):
#     context = {
#         'usertype' : 'Customer',
#     }
#     return render(request, "login.html", context)


class ManagerLoginView(View):
    @check_if_anonymous
    def get(self, request):
        context = {
            'usertype' : 'Manager',
        }
        return render(request, "login.html", context)

    @check_if_anonymous
    def post(self, request):
        username = request.POST.get("username")
        password = request.POST.get("password")


        cursor = connection.cursor()
        sql = "SELECT PASSWORD FROM MANAGERS WHERE ADMIN_ID=%s"
        cursor.execute(sql, [username])
        result = cursor.fetchall()
        cursor.close()


        if len(result) > 0 and result[0][0] == password:
            request.session['username'] = username
            request.session['usertype'] = 'manager'
            return redirect('admin-panel')
        else:
            messages.error(request, 'Username or Password incorrect')
            return redirect('manager-login-view')


class CustomerRegistrationView(View):
    @check_if_anonymous
    def get(self, request):
        return render(request, 'customer_registration.html')

    @check_if_anonymous
    def post(self, request):
        print(request.POST)
        fullname = request.POST.get('fullname')
        email = request.POST.get('email')
        address = request.POST.get('address')
        cont_number = request.POST.get('cont_number')

        username = request.POST.get('username')
        password1 = request.POST.get('password1')
        password2 = request.POST.get('password2')

        if fullname is None or email is None or address is None or cont_number is None or username is None or username is None or password1 is None or password2 is None:
            messages.error(request, 'Fill out all the fields')
            return redirect('customer-registration-view')

        cursor = connection.cursor()
        sql = "SELECT COUNT(*) FROM CUSTOMERS WHERE CUSTOMER_ID=%s"
        cursor.execute(sql, [username])
        cnt = cursor.fetchall()
        cursor.close()

        if int(cnt[0][0]) != 0:
            messages.error(request, 'Username taken. Try again')
            return redirect('customer-registration-view')

        if password1 != password2:
            messages.error(request, 'Password mismatch')
            return redirect('customer-registration-view')

        cont_number = cont_number.split(',')

        for i in range(0, len(cont_number)):
            cont_number[i] = cont_number[i].strip()

        cont_number = list(set(cont_number)) # removes duplicates

        cursor = connection.cursor()
        sql = """
                INSERT INTO CUSTOMERS (CUSTOMER_ID, NAME, ADDRESS, EMAIL, ACCOUNT_CREATED_ON, PASSWORD)
                VALUES (%s, %s, %s, %s, %s, %s)
                """
        cursor.execute(sql, [username, fullname, address, email, datetime.datetime.now(), password1])
        cursor.close()

        for i in cont_number:
            cursor = connection.cursor()
            sql = """
                    INSERT INTO CUSTOMER_CONTACT_NUMBER (CUSTOMER_ID, CONTACT_NUMBER)
                    VALUES (%s, %s)
                    """
            cursor.execute(sql, [username, i])
            cursor.close()

        request.session['username'] = username
        request.session['usertype'] = 'customer'

        messages.success(request, 'Registration complete 🎉')

        return redirect('homepage')
