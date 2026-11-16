import 'pizza.dart';
import 'order_status.dart';

class PizzaOrder {
  final String orderId;
  final List<Pizza> pizzas;
  final double totalPrice;
  final OrderStatus status;
  final DateTime createdAt;

  const PizzaOrder({
    required this.orderId,
    required this.pizzas,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });
}