from django.http import HttpResponse


# Create your views here.

def hello_wolrd(request):
    return HttpResponse("<title>Test Server</title><h2>Hello world!</h2>This is just Test Server. - 1.6.1 version!")
