import 'package:intl/intl.dart';

class Order {
  final String name;
  final String price;
  final DateTime date;
  final String details;
  final String dateString;

  Order({
    required this.name,
    required this.price,
    required this.date,
    required this.details,
  }) : dateString = DateFormat('dd/MM/yyyy').format(date);
}
