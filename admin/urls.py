from django.urls import path
from admin import views

urlpatterns = [
    path('manage/', views.AdminPanel.as_view(), name = 'admin-panel'),
    path('manage/customer-list/', views.AdminCustomerListView.as_view(), name = 'admin-customer-list-view'),
    path('manage/book-list/', views.AdminBookListView.as_view(), name = 'admin-book-list-view'),
    path('manage/author-list/', views.AdminAuthorListView.as_view(), name = 'admin-author-list-view'),
    path('manage/publisher-list/', views.AdminPublisherListView.as_view(), name = 'admin-publisher-list-view'),
    path('manage/order-log/', views.AdminOrderLogView.as_view(), name = 'admin-order-log-view'),
    path('manage/offer-list/', views.AdminOfferListView.as_view(), name = 'admin-offer-list-view'),
    path('manage/borrows/', views.AdminBorrowsView.as_view(), name = 'admin-borrows-view'),

    # path('test/', views.Test.as_view(), name = 'test'),
]
