import 'package:intl/intl.dart';
import 'register.dart';
import 'new_employee.dart';
import 'new_order.dart';

class Order {
  String name;
  String price;
  DateTime date;
  String details;
  String dateString;

  Order({
    required this.name,
    required this.price,
    required this.date,
    required this.details,
  }) : dateString = DateFormat('dd/MM/yyyy').format(date);

  void updateOrder({
    String? name,
    String? price,
    String? details,
    DateTime? date,
  }) {
    if (name != null) this.name = name;
    if (price != null) this.price = price;
    if (details != null) this.details = details;
    if (date != null) this.date = date;
  }

  void deleteOrder() {
    for (final customer in allCustomers) {
      customer.orders.remove(this);
    }

    for (final employee in allEmployees) {
      employee.orders.remove(this);
      employee.calculateValue();
    }

    allOrders.remove(this);
  }
}
