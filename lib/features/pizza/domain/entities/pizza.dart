enum PizzaSize { small, medium, large }

enum CrustType { thin, thick, stuffed }

class Pizza {
  final String id;
  final String name;
  final PizzaSize size;
  final CrustType crust;
  final List<String> toppings;
  final double basePrice;

  const Pizza({
    required this.id,
    required this.name,
    required this.size,
    required this.crust,
    required this.toppings,
    required this.basePrice,
  });
}