from django.db import models
from datetime import datetime
from django import forms


# Create your models here.
class Book(models.Model):

    title = models.CharField(max_length=50, blank=False)
    author = models.CharField(max_length=50, blank=False)
    publish_year = models.DecimalField(max_digits=4, decimal_places=0)
    edition = models.IntegerField(default=1)
    
    def __str__(self) -> str:
        return f'{self.title}, by: {self.author} - {self.publish_year}, ed: {self.edition}'

class Member(models.Model):

    name = models.CharField(max_length=30, blank=False)
    address = models.CharField(max_length=100)
    phone_number = models.DecimalField(max_digits=11, decimal_places=0)
    
    def __str__(self) -> str:
        return self.name

class Booking(models.Model):
    member = models.ForeignKey(Member, on_delete=models.CASCADE)
    book = models.ForeignKey(Book, on_delete=models.CASCADE)
    expiration_date = models.DateField()
    
    def save(self, *args, **kwargs):
        old_booking = Booking.objects.filter(book=self.book, member=self.member)
        if not old_booking.exists():
            super().save(*args, **kwargs)

    def clean(self):
        if self.expiration_date < datetime.now().date():
            raise forms.ValidationError("The expiration date is already gone!")
        if  Booking.objects.filter(member=self.member).exists():
            latest_booking = Booking.objects.filter(member=self.member).latest('expiration_date')
            if datetime.now().date() < latest_booking.expiration_date:
                if latest_booking.book != self.book:
                    raise forms.ValidationError("An active booking already exists!")
                elif latest_booking.expiration_date < self.expiration_date:
                    Booking.objects.filter(pk=latest_booking.pk).update(expiration_date=self.expiration_date)
                else:
                    raise forms.ValidationError("An active booking has longer expiration date!")
