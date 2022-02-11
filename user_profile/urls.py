from django.urls import path
from user_profile import views

urlpatterns = [
    path('user/<cid>', views.show_profile, name = 'user-profile'),
    path('user/<cid>/my-cart/', views.MyCartView.as_view(), name= 'user-profile-cart')
    # path('manage/customer-list/', views.AdminCustomerListView.as_view(), name = 'admin-customer-list-view'),
    # path('manage/book-list/', views.AdminBookListView.as_view(), name = 'admin-book-list-view'),
    # path('manage/author-list/', views.AdminAuthorListView.as_view(), name = 'admin-author-list-view'),
    # path('manage/order-log/', views.AdminOrderLogView.as_view(), name = 'admin-order-log-view'),
]
