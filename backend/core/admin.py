from django.contrib import admin
from django.contrib.admin import SimpleListFilter
from .models import User, Category, Service, Order, Payment, SMSCode

# Custom filter for User by phone number
class PhoneFilter(SimpleListFilter):
    title = 'Phone Number'
    parameter_name = 'phone'

    def lookups(self, request, model_admin):
        return [(user.phone, user.phone) for user in User.objects.all().distinct()]

    def queryset(self, request, queryset):
        if self.value():
            return queryset.filter(phone=self.value())
        return queryset

# Custom filter for Category by name
class CategoryNameFilter(SimpleListFilter):
    title = 'Category Name'
    parameter_name = 'name'

    def lookups(self, request, model_admin):
        return [(category.name, category.name) for category in Category.objects.all().distinct()]

    def queryset(self, request, queryset):
        if self.value():
            return queryset.filter(name=self.value())
        return queryset

# Custom filter for Service by name
class ServiceNameFilter(SimpleListFilter):
    title = 'Service Name'
    parameter_name = 'name'

    def lookups(self, request, model_admin):
        return [(service.name, service.name) for service in Service.objects.all().distinct()]

    def queryset(self, request, queryset):
        if self.value():
            return queryset.filter(name=self.value())
        return queryset

# Custom admin for User
@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'phone', 'email', 'role', 'region', 'quantity_order', 'rating')
    list_filter = (PhoneFilter, 'role', 'region')
    search_fields = ('name', 'phone', 'email')
    actions = ['delete_selected_users']

    def delete_selected_users(self, request, queryset):
        queryset.delete()
        self.message_user(request, f"Deleted {queryset.count()} users.")

# Custom admin for Category
@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('id', 'name')
    list_filter = (CategoryNameFilter,)
    search_fields = ('name',)
    actions = ['delete_selected_categories']

    def delete_selected_categories(self, request, queryset):
        queryset.delete()
        self.message_user(request, f"Deleted {queryset.count()} categories.")

# Custom admin for Service
@admin.register(Service)
class ServiceAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'description', 'category', 'price')
    list_filter = (ServiceNameFilter, 'category')
    search_fields = ('name', 'description')
    actions = ['delete_selected_services']

    def delete_selected_services(self, request, queryset):
        queryset.delete()
        self.message_user(request, f"Deleted {queryset.count()} services.")

# Custom admin for Order
@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ('id', 'service', 'client', 'executor', 'date_order', 'status')
    list_filter = ('status', 'date_order')
    search_fields = ('service__name', 'client__name', 'executor__name')

# Custom admin for Payment
@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = ('id', 'order', 'client', 'executor', 'date_order', 'status')
    list_filter = ('status', 'date_order')
    search_fields = ('order__id', 'client__name', 'executor__name')

# Custom admin for SMSCode
@admin.register(SMSCode)
class SMSCodeAdmin(admin.ModelAdmin):
    list_display = ('phone', 'code', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('phone', 'code')
