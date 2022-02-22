from unicodedata import name
from django.urls import path
from user_profile import views

urlpatterns = [
    path('user/<cid>', views.show_profile, name = 'user-profile'),
    path('user/<cid>/my-cart/', views.MyCartView.as_view(), name= 'user-profile-cart'),
    path('user/<cid>/my-wishlist/', views.MyWishListView.as_view(), name= 'user-profile-wishlist'),
    path('user/<cid>/my-orders/', views.MyOrderView.as_view(), name= 'user-profile-orders'),
    path('user/<cid>/my-account/', views.MyAccountView.as_view(), name= 'user-profile-account'),
    path('user/<cid>/my-borrows/', views.MyBorrowsView.as_view(), name= 'user-profile-borrows'),
    # path('user/<cid>/my-subscription/', views.MySubscriptionView.as_view(), name= 'user-profile-subscription'),
]
