from django.shortcuts import render


# Create your views here.

def show_admin(request):
    return render(request, 'admin_panel.html')
