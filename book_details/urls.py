from django.urls import path
from book_details import views

urlpatterns = [
    path('books/<isbn>', views.BookDetailsView.as_view(), name = 'book_details'),
]