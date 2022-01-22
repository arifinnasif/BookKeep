from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.CustomerLoginView.as_view(), name="customer-login-view"),
    path('logout/', views.CustomerLogoutView.as_view(), name="customer-logout-view"),
]
