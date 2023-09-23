import 'package:flutter/material.dart';
import 'order.dart';

class EditOrderPage extends StatelessWidget {
  final Order order;

  EditOrderPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Pedido - ${order.name}'),
        backgroundColor: Colors.blue[800],
      ),
    );
  }
}
