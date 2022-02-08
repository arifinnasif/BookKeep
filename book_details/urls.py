from django.urls import path
from book_details import views

urlpatterns = [
    path('books/<isbn>', views.UserBookDetailsView.as_view(), name='book_page'),
    # path('book/<isbn>/add_review', views.add_review, name='add_review'),
]
