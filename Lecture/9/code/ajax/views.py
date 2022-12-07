from django.contrib.auth.forms import UserCreationForm
from django.views.generic.edit import CreateView
from django.contrib.auth.models import User
from django.http import JsonResponse
from django.urls import reverse_lazy

class SignUpView(CreateView):
    template_name = 'ajax/signup.html'
    form_class = UserCreationForm
    success_url = reverse_lazy('signup')

def validate_username(request):
    username = request.GET.get('username', None)
    data = {
        'is_taken': User.objects.filter(username__iexact=username).exists()
    }
    if data['is_taken']:
        data['error_message'] = 'A user with this username already exists.'
    return JsonResponse(data)