enum OrderStatus {
  pending,
  preparing,
  baking,
  outForDelivery,
  delivered,
  cancelled,
}

extension OrderStatusX on OrderStatus {
  bool get canBeCancelled => this == OrderStatus.pending;

  bool canTransitionTo(OrderStatus nextStatus) {
    switch (this) {
      case OrderStatus.pending:
        return nextStatus == OrderStatus.preparing ||
            nextStatus == OrderStatus.cancelled;
      case OrderStatus.preparing:
        return nextStatus == OrderStatus.baking;
      case OrderStatus.baking:
        return nextStatus == OrderStatus.outForDelivery;
      case OrderStatus.outForDelivery:
        return nextStatus == OrderStatus.delivered;
      case OrderStatus.delivered:
      case OrderStatus.cancelled:
        return false; // Terminal states
    }
  }
}