from django.shortcuts import render
from django.http import HttpResponseRedirect
from django.urls import reverse
from django.contrib.auth import authenticate, login, logout

# Create your views here.
def index(request):
    if not request.user.is_authenticated:
        return HttpResponseRedirect(reverse("users:login"))
    return render(request, "users/user.html")

def login_view(request):
    if request.method == "POST":
        usr = request.POST['username']
        pas = request.POST['password']
        user = authenticate(request, username=usr, password=pas)
        if user is not None:
            login(request, user)
            return HttpResponseRedirect(reverse("users:index"))
        else:
            context = {"message": "Invalid credentials."}
            return render(request, "users/login.html", context)

    return render(request, 'users/login.html')

def logout_view(request):
    logout(request)
    context = {"message": "Logged out"}
    return render(request, "users/login.html", context)

