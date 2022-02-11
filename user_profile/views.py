from django.shortcuts import render
from django.db import connection

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
        "username" : username,
        "usertype" : usertype,
    }

    return render (request, 'user_profile.html', context)
