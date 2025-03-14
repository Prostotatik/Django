from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from core.views import UserViewSet, CategoryViewSet, ServiceViewSet, OrderViewSet, PaymentViewSet, RegisterView, VerifyCodeView

router = DefaultRouter()
router.register(r'api/users', UserViewSet)
router.register(r'api/categories', CategoryViewSet)
router.register(r'api/services', ServiceViewSet)
router.register(r'api/orders', OrderViewSet)
router.register(r'api/payments', PaymentViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),  # Must be present
    path('api/register/', RegisterView.as_view()),
    path('api/verify-code/', VerifyCodeView.as_view()),
    path('', include(router.urls)),
]
