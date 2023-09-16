import 'order.dart';

class Employee {
  final String name;
  final String phone;
  List<Order> orders = const [];
  double value = 0;

  Employee({
    required this.name,
    required this.orders,
    required this.phone,
  }) {
    calculateValue();
  }

  void calculateValue() {
    double totalValue = 0;
    for (var order in orders) {
      final orderPrice = double.tryParse(order.price) ?? 0;
      totalValue += orderPrice;
    }

    value = totalValue * 0.10;
  }
}
