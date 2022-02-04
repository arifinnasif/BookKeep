from django.urls import path
from book_details import views

urlpatterns = [
    path('books/<isbn>', views.UserBookDetailsView.as_view(), name='book_details'),
]
