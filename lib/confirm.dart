import 'package:flutter/material.dart';
import 'new_order.dart';
import 'edit_order.dart';
import 'order.dart';
import 'register.dart';
import 'new_employee.dart';

List<Order> completedOrder = [];

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Confirmar pedido'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView.builder(
        itemCount: allOrders.length,
        itemBuilder: (context, index) {
          final order = allOrders[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.only(bottom: 16.0, top: 8.0),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome do Pedido: ${order.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text('Preço do Pedido: R\$${order.price}'),
                Text('Detalhes do pedido:\n${order.details}'),
                Text('Data do Pedido: ${order.dateString}'),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // adicionar funcao confirmar pedido
                      },
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: const Text('Concluído',
                          style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final editedOrder = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditOrderPage(order: order),
                          ),
                        );

                        if (editedOrder != null) {
                          // Verifica se o pedido foi editado
                          final orderIndex = allOrders.indexOf(order);
                          if (orderIndex != -1) {
                            // Atualiza a lista de pedidos com o pedido editado
                            allOrders[orderIndex] = editedOrder;
                            setState(() {});
                          }
                        }
                      },
                      icon:
                          const Icon(Icons.create_rounded, color: Colors.white),
                      label: const Text('Editar',
                          style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.yellow[800]),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        order.deleteOrder();

                        for (final customer in allCustomers) {
                          customer.orders.remove(order);
                        }

                        for (final employee in allEmployees) {
                          employee.orders.remove(order);
                          employee.calculateValue();
                        }

                        allOrders.remove(order);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Pedido excluído com sucesso!'),
                          ),
                        );

                        setState(() {});
                      },
                      icon:
                          const Icon(Icons.close_rounded, color: Colors.white),
                      label: const Text('Excluir',
                          style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
