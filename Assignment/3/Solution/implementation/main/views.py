from django.urls import reverse_lazy
from django.views.generic import ListView
from django.views.generic.edit import CreateView
from django.http import HttpResponse
from . import models


# Create your views here.

def index(request):
    return HttpResponse("Hello. You're at the project index.")

class MemberListView(ListView):
    model = models.Member
    template_name = 'main/member_list.html'

class BookListView(ListView):
    model = models.Book
    template_name = 'main/book_list.html'

class BookingListView(ListView):
    model = models.Booking
    template_name = 'main/booking_list.html'
    def get_queryset(self):
        return models.Booking.objects.order_by('-expiration_date')

class CreateBookingView(CreateView):
    model = models.Booking
    fields = ('member', 'book', 'expiration_date')

    template_name = 'main/create_booking.html'
    success_url = reverse_lazy('main:booking_list')
    