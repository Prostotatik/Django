from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import UserViewSet, CategoryViewSet, ServiceViewSet, OrderViewSet, PaymentViewSet, RegisterView, VerifyCodeView

router = DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'categories', CategoryViewSet)
router.register(r'services', ServiceViewSet)
router.register(r'orders', OrderViewSet)
router.register(r'payments', PaymentViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('register/', RegisterView.as_view(), name='register'),
    path('verify-code/', VerifyCodeView.as_view(), name='verify-code'),
]
