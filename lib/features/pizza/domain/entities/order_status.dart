enum OrderStatus {
  pending,
  preparing,
  baking,
  outForDelivery,
  delivered,
  cancelled
}

extension OrderStatusExtension on OrderStatus {
  // الإلغاء مسموح فقط إذا كان الطلب قيد الانتظار
  bool get canBeCancelled => this == OrderStatus.pending;
}