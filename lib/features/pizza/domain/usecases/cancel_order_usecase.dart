import '../entities/order_status.dart';
import '../repositories/pizza_order_repository.dart';

class CancelOrderUseCase {
  final PizzaOrderRepository repository;

  const CancelOrderUseCase(this.repository);

  Future<void> execute(String orderId) async {
    final order = await repository.getOrderById(orderId);

    if (!order.status.canBeCancelled) {
      throw StateError(
        'Order cannot be cancelled in ${order.status.name} state. Cancellation is only allowed while pending.',
      );
    }

    await repository.cancelOrder(orderId);
  }
}