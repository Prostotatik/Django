from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import UserViewSet, CategoryViewSet, SubCategoryViewSet, ServiceViewSet, OrderViewSet, PaymentViewSet, RegisterView, VerifyCodeView

router = DefaultRouter()
router.register(r'api/users', UserViewSet)
router.register(r'api/categories', CategoryViewSet)
router.register(r'api/subcategories', SubCategoryViewSet)  # Consistent prefix
router.register(r'api/services', ServiceViewSet)
router.register(r'api/orders', OrderViewSet)
router.register(r'api/payments', PaymentViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('api/register/', RegisterView.as_view(), name='register'),  # Consistent prefix
    path('api/verify-code/', VerifyCodeView.as_view(), name='verify-code'),
]
