import '../entities/pizza.dart';

class CalculatePizzaPriceUseCase {
  static const double _ToppingPrice = 1.25;

  double execute(Pizza pizza) {
    double sizeMultiplier = switch (pizza.size) {
      PizzaSize.small => 1.0,
      PizzaSize.medium => 1.25,
      PizzaSize.large => 1.5,
    };

    double crustExtra = switch (pizza.crust) {
      CrustType.thin => 0.0,
      CrustType.thick => 1.50,
      CrustType.stuffed => 3.00,
    };

    double toppingsTotal = pizza.toppings.length * _ToppingPrice;

    return (pizza.basePrice * sizeMultiplier) + crustExtra + toppingsTotal;
  }
}