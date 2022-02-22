from django.utils.decorators import wraps
from django.shortcuts import render, redirect
from django.contrib import messages
from django.db import connection

from django.http import HttpResponseForbidden

def check_if_authorized_manager(func):
    @wraps(func)
    def wrapped(self, request, *args, **kwargs):
        if request.session.get('usertype') != 'manager' or len(request.session.get('username')) == 0:
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


def check_if_authorized_customer(func):
    @wraps(func)
    def wrapped(self, request, *args, **kwargs):
        if request.session.get('usertype') != 'customer' or len(request.session.get('username')) == 0:
            messages.error(request, "You are not logged in")
            return redirect('customer-login-view')

        username = request.session['username']
        cursor = connection.cursor()
        sql = "SELECT PASSWORD FROM CUSTOMERS WHERE CUSTOMER_ID=%s"
        cursor.execute(sql, [username])
        result = cursor.fetchall()
        cursor.close()

        if len(result) == 0:
            messages.error(request, "Something went wrong")
            return redirect('customer-login-view')

        return func(self, request, *args, **kwargs)

    return wrapped


def check_if_specific_authorized_customer(func):
    @wraps(func)
    def wrapped(self, request, cid, *args, **kwargs):
        if request.session.get('usertype') != 'customer' or len(request.session.get('username')) == 0:
            messages.error(request, "You are not logged in")
            return redirect('customer-login-view')

        username = request.session['username']
        if username != cid:
            # messages.error(request, "You don't have the access to this page")
            return HttpResponseForbidden()
        cursor = connection.cursor()
        sql = "SELECT PASSWORD FROM CUSTOMERS WHERE CUSTOMER_ID=%s"
        cursor.execute(sql, [username])
        result = cursor.fetchall()
        cursor.close()

        if len(result) == 0:
            messages.error(request, "Something went wrong")
            return redirect('customer-login-view')

        return func(self, request, cid, *args, **kwargs)

    return wrapped


def check_if_anonymous(func):
    @wraps(func)
    def wrapped(self, request, *args, **kwargs):
        if request.session.get('usertype') == 'customer' and len(request.session.get('username')) != 0:
            username = request.session['username']
            cursor = connection.cursor()
            sql = "SELECT PASSWORD FROM CUSTOMERS WHERE CUSTOMER_ID=%s"
            cursor.execute(sql, [username])
            result = cursor.fetchall()
            cursor.close()

            if len(result) == 0:
                request.session.flush()
                messages.error(request, "Something went wrong")
                return redirect('customer-login-view')

            return redirect('homepage')

        if request.session.get('usertype') == 'manager' and len(request.session.get('username')) != 0:
            username = request.session['username']
            cursor = connection.cursor()
            sql = "SELECT PASSWORD FROM MANAGERS WHERE ADMIN_ID=%s"
            cursor.execute(sql, [username])
            result = cursor.fetchall()
            cursor.close()

            if len(result) == 0:
                request.session.flush()
                messages.error(request, "Something went wrong")
                return redirect('customer-login-view')

            return redirect('admin-panel')


        request.session.flush()
        return func(self, request, *args, **kwargs)

    return wrapped
