import 'customer.dart';

class Order {
  final String name;
  final String price;
  final Customer customer;

  Order({
    required this.name,
    required this.price,
    required this.customer,
  });
}
