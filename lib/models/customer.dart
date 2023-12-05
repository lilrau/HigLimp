import 'order.dart';

class Customer {
  final String name;
  final String phone;
  final String address;
  final String email;
  List<Order> orders = const [];

  Customer({
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.orders,
  });
}
