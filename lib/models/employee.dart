import 'dart:math';

import 'order.dart';

class Employee {
  String id = '';
  final String name;
  final String phone;
  List<Order> orders = [];
  List<Order> completedOrders = [];
  double value = 0;

  Employee({
    required this.name,
    required this.orders,
    required this.phone,
  }) {
    generateUniqueId();
    calculateValue();
  }

  void generateUniqueId() {
    final DateTime now = DateTime.now();
    final int timestamp = now.microsecondsSinceEpoch;
    final int random = Random().nextInt(999999);

    id = '$timestamp$random';
  }

  void calculateValue() {
    double totalValue = 0;
    for (var order in completedOrders) {
      final orderPrice = double.tryParse(order.price) ?? 0;
      totalValue += orderPrice;
    }

    value = totalValue * 0.10;
  }
}
