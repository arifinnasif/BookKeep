from django.utils.decorators import wraps
from django.shortcuts import render, redirect
from django.contrib import messages
from django.db import connection

def check_if_authorized_manager(func):
    @wraps(func)
    def wrapped(self, request, *args, **kwargs):
        if request.session['usertype'] != 'manager' and len(request.session['username']) == 0:
            messages.error(request, "You don't have the authorization")
            return redirect('manager-login-view')

        username = request.session['username']
        cursor = connection.cursor()
        sql = "SELECT PASSWORD FROM MANAGERS WHERE ADMIN_ID=%s"
        cursor.execute(sql, [username])
        result = cursor.fetchall()
        cursor.close()

        if len(result) == 0:
            messages.error(request, "You don't have the authorization")
            return redirect('manager-login-view')

        return func(self, request, *args, **kwargs)

    return wrapped
