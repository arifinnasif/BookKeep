from django.shortcuts import render

# Create your views here.
def show_homepage(request):
    context = {
        "books" : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
    }
    return render(request, 'catalog.html', context)
