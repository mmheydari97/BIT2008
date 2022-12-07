from django.urls import path
from . import views

app_name = 'main'
urlpatterns = [
    path("", views.index, name='index'),
    path("books", views.BookListView.as_view(), name='book_list'),
    path("members", views.MemberListView.as_view(), name='member_list'),
    path("bookings", views.BookingListView.as_view(), name='booking_list'),
    path("bookings/add", views.CreateBookingView.as_view(), name='create_booking'),

]
