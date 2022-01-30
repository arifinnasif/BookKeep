from django.urls import path
from admin import views

urlpatterns = [
    path('manage/', views.show_admin, name = 'admin'),
]
