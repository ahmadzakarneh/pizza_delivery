import '../entities/pizza_order.dart';
import '../entities/order_status.dart';

abstract class PizzaOrderRepository {
  Future<void> placeOrder(PizzaOrder order);
  Future<PizzaOrder> getOrderById(String orderId);
  Future<List<PizzaOrder>> getUserOrders();
  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus);
  Future<void> cancelOrder(String orderId);
}