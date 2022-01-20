from django.shortcuts import render, redirect
from django.db import connection
from django.views import View


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

        print(result)

        if result[0][0] == password:
            print("SUCCESSFUL")
        else:
            print("FAILED")

        return redirect('homepage')


def show_login_page(request):
    return render(request, "login.html")
