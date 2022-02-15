from unicodedata import name
from django.urls import path
from user_profile import views

urlpatterns = [
    path('user/<cid>', views.show_profile, name = 'user-profile'),
    path('user/<cid>/my-cart/', views.MyCartView.as_view(), name= 'user-profile-cart'),
    path('user/<cid>/my-orders/', views.MyOrderView.as_view(), name= 'user-profile-orders'),
]
