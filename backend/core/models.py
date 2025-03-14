from django.db import models
from phonenumber_field.modelfields import PhoneNumberField

class User(models.Model):
    name = models.CharField(max_length=255)
    email = models.EmailField(unique=True, null=True, blank=True)
    phone = PhoneNumberField(unique=True)
    address = models.TextField(null=True, blank=True)
    role = models.CharField(max_length=50, choices=[('client', 'Client'), ('executor', 'Executor')])
    password = models.CharField(max_length=255, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    region = models.CharField(max_length=100, null=True, blank=True)
    quantity_order = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    rating = models.IntegerField(default=0)

    class Meta:
        db_table = 'users'

    def __str__(self):
        return self.name

class Category(models.Model):
    name = models.CharField(max_length=255)

    class Meta:
        db_table = 'categories'

    def __str__(self):
        return self.name

class Service(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField()
    category = models.ForeignKey(Category, on_delete=models.CASCADE, related_name='services')
    price = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        db_table = 'services'

    def __str__(self):
        return self.name

class Order(models.Model):
    service = models.ForeignKey(Service, on_delete=models.CASCADE, related_name='orders')
    client = models.ForeignKey(User, on_delete=models.CASCADE, related_name='client_orders')
    executor = models.ForeignKey(User, on_delete=models.CASCADE, related_name='executor_orders')
    date_order = models.DateTimeField(auto_now_add=True)
    date_execution = models.DateTimeField(null=True, blank=True)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=50, choices=[('pending', 'Pending'), ('completed', 'Completed'), ('cancelled', 'Cancelled')])

    class Meta:
        db_table = 'orders'

    def __str__(self):
        return f"Order {self.id} for {self.service.name}"

class Payment(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='payments')
    client = models.ForeignKey(User, on_delete=models.CASCADE, related_name='client_payments')
    executor = models.ForeignKey(User, on_delete=models.CASCADE, related_name='executor_payments')
    date_order = models.DateTimeField(auto_now_add=True)
    date_execution = models.DateTimeField(null=True, blank=True)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=50, choices=[('pending', 'Pending'), ('completed', 'Completed'), ('cancelled', 'Cancelled')])

    class Meta:
        db_table = 'payments'

    def __str__(self):
        return f"Payment {self.id} for Order {self.order.id}"

class SMSCode(models.Model):
    phone = PhoneNumberField()
    code = models.CharField(max_length=6)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'sms_codes'

    def __str__(self):
        return f"Code {self.code} for {self.phone}"
