import 'package:flutter/material.dart';
import '../models/order.dart';
import 'package:intl/intl.dart';

class OrderListPage extends StatelessWidget {
  final List<Order> orders;

  const OrderListPage(this.orders, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos do dia'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome do Pedido: ${order.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Preço do Pedido: R\$${order.price}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Detalhes do Pedido: \n${order.details}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Data do Pedido: ${DateFormat('yyyy/MM/dd HH:mm').format(order.date)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
