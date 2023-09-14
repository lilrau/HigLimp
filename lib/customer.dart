import 'order.dart';

class Customer {
  final String name;
  final String phone;
  final String address;
  final String email;
  final List<Order> orders;

  Customer({
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.orders,
  });
}
