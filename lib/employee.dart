import 'order.dart';

class Employee {
  final String name;
  List<Order> orders = const [];

  Employee({
    required this.name,
    required this.orders,
  });
}
