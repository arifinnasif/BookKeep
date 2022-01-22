from django.shortcuts import render, redirect
from django.db import connection
from django.views import View
from django.contrib import messages


# Create your views here.
class CustomerLoginView(View):
    def get(self, request):
        return render(request, 'login.html')

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


def show_login_page(request):
    return render(request, "login.html")
