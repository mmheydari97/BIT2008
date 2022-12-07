from django.contrib import admin
from . import models
from django.db.models import Avg
from django.urls import reverse
from django.utils.http import urlencode
from django.utils.html import format_html
from django import forms


admin.site.register(models.Grade)


class PersonAdminForm(forms.ModelForm):
    class Meta:
        model = models.Person
        fields = "__all__"

    def clean_first_name(self):
        if self.cleaned_data["first_name"] == "Spike":
            raise forms.ValidationError("No Vampires")

        return self.cleaned_data["first_name"]



@admin.register(models.Person)
class PersonAdmin(admin.ModelAdmin):
    form = PersonAdminForm

    fields = ("first_name", "last_name", "courses")
    list_display = ("last_name", "first_name", "show_average")
    search_fields = ("last_name__startswith", )

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        form.base_fields["first_name"].label = "First Name (Humans only!):"
        return form

    def show_average(self, obj):
        result = models.Grade.objects.filter(person=obj).aggregate(Avg("grade"))
        return result["grade__avg"]
    show_average.short_description = "Average Grade"


@admin.register(models.Course)
class CourseAdmin(admin.ModelAdmin):
    list_display = ("name", "year", "view_students_link")
    list_filter = ("year", )

    def view_students_link(self, obj):
        count = obj.students.count() # related_name
        url = (
            reverse("admin:core_person_changelist")
            + "?"
            + urlencode({"courses__id": f"{obj.id}"})
        )
        return format_html(f'<a href="{url}">{count} Students</a>')

    view_students_link.short_description = "Students"