import '../entities/order_status.dart';
import '../repositories/pizza_order_repository.dart';

class UpdateOrderStatusUseCase {
  final PizzaOrderRepository repository;

  const UpdateOrderStatusUseCase(this.repository);

  Future<void> execute(String orderId, OrderStatus nextStatus) async {
    final order = await repository.getOrderById(orderId);

    if (!order.status.canTransitionTo(nextStatus)) {
      throw StateError(
        'Invalid FSM state transition from ${order.status.name} to ${nextStatus.name}.',
      );
    }

    await repository.updateOrderStatus(orderId, nextStatus);
  }
}