from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
import random
from django.utils import timezone
from datetime import timedelta
from .models import User, Category, SubCategory, Service, Order, Payment, SMSCode
from .serializers import UserSerializer, CategorySerializer, SubCategorySerializer, ServiceSerializer, OrderSerializer, PaymentSerializer

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

class SubCategoryViewSet(viewsets.ModelViewSet):
    queryset = SubCategory.objects.all()
    serializer_class = SubCategorySerializer

class ServiceViewSet(viewsets.ModelViewSet):
    queryset = Service.objects.all()
    serializer_class = ServiceSerializer

class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

class PaymentViewSet(viewsets.ModelViewSet):
    queryset = Payment.objects.all()
    serializer_class = PaymentSerializer

class RegisterView(APIView):
    def post(self, request):
        phone = request.data.get('phone')
        if not phone:
            return Response({"error": "Phone number is required"}, status=status.HTTP_400_BAD_REQUEST)

        code = str(random.randint(100000, 999999))
        SMSCode.objects.create(phone=phone, code=code)

        print(f"SMS Code for {phone}: {code}")  # Simulate SMS
        return Response({"message": "Code sent to phone"}, status=status.HTTP_200_OK)

class VerifyCodeView(APIView):
    def post(self, request):
        phone = request.data.get('phone')
        code = request.data.get('code')
        if not phone or not code:
            return Response({"error": "Phone and code are required"}, status=status.HTTP_400_BAD_REQUEST)

        sms_code = SMSCode.objects.filter(phone=phone, code=code).first()
        if not sms_code:
            return Response({"error": "Invalid code"}, status=status.HTTP_400_BAD_REQUEST)

        # Ensure created_at is timezone-aware for comparison
        created_at = timezone.make_aware(sms_code.created_at, timezone.get_current_timezone())
        if created_at < timezone.now() - timedelta(minutes=5):
            return Response({"error": "Code expired"}, status=status.HTTP_400_BAD_REQUEST)

        user, created = User.objects.get_or_create(phone=phone, defaults={'name': 'New User', 'role': 'client'})
        sms_code.delete()

        return Response({"message": "User registered", "user_id": user.id}, status=status.HTTP_200_OK)
