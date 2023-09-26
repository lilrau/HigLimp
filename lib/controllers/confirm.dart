import 'package:flutter/material.dart';
import 'new_order.dart';
import 'edit_order.dart';
import 'register.dart';
import 'new_employee.dart';

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
        title: const Text('Lista de Pedidos'),
        backgroundColor: Colors.blue[800],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Pedidos aguardando confirmação',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: waitingOrders.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 16.0);
              },
              // Constroi a lista de pedidos aguardando confirmacao
              itemBuilder: (context, index) {
                final order = waitingOrders[index];
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
                          // Botao concluir pedido
                          ElevatedButton.icon(
                            onPressed: () {
                              order.completeOrder();

                              // Remove o pedido da lista waitingOrders
                              final waitingOrderIndex =
                                  waitingOrders.indexOf(order);
                              if (waitingOrderIndex != -1) {
                                waitingOrders.removeAt(waitingOrderIndex);
                              }
                              setState(() {});
                            },
                            icon: const Icon(Icons.check, color: Colors.white),
                            label: const Text('Concluído',
                                style: TextStyle(color: Colors.white)),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                          ),
                          // Botao editar pedido
                          ElevatedButton.icon(
                            onPressed: () async {
                              final editedOrder = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditOrderPage(order: order),
                                ),
                              );

                              if (editedOrder != null) {
                                // Verifica se o pedido foi editado
                                final orderIndex = allOrders.indexOf(order);
                                if (orderIndex != -1) {
                                  // Atualiza a lista de pedidos com o pedido editado
                                  allOrders[orderIndex] = editedOrder;

                                  // Procura e atualiza o pedido na lista waitingOrders
                                  final waitingOrderIndex =
                                      waitingOrders.indexOf(order);
                                  if (waitingOrderIndex != -1) {
                                    waitingOrders[waitingOrderIndex] =
                                        editedOrder;
                                  }

                                  setState(() {});
                                }
                              }
                            },
                            icon: const Icon(Icons.create_rounded,
                                color: Colors.white),
                            label: const Text('Editar',
                                style: TextStyle(color: Colors.white)),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.yellow[800]),
                            ),
                          ),
                          // Botao excluir pedido
                          ElevatedButton.icon(
                            onPressed: () {
                              order.deleteOrder();

                              // Remove o pedido do cliente
                              for (final customer in allCustomers) {
                                customer.orders.remove(order);
                              }

                              // Remove o pedido do funcionário
                              for (final employee in allEmployees) {
                                employee.orders.remove(order);
                                employee.calculateValue();
                              }

                              // Remove o pedido da lista waitingOrders
                              final waitingOrderIndex =
                                  waitingOrders.indexOf(order);
                              if (waitingOrderIndex != -1) {
                                waitingOrders.removeAt(waitingOrderIndex);
                              }

                              // Remove o pedido da lista geral
                              allOrders.remove(order);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Pedido excluído com sucesso!'),
                                ),
                              );

                              setState(() {});
                            },
                            icon: const Icon(Icons.close_rounded,
                                color: Colors.white),
                            label: const Text('Excluir',
                                style: TextStyle(color: Colors.white)),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Pedidos concluídos',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            // Constroi a lista de clientes
            child: ListView.separated(
              itemCount: allEmployees.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 16.0);
              },
              // Constroi a lista de pedidos por cliente
              itemBuilder: (context, employeeIndex) {
                final employee = allEmployees[employeeIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Pedidos concluídos de ${employee.name}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: employee.completedOrders.length,
                      itemBuilder: (context, orderIndex) {
                        final order = employee.completedOrders[orderIndex];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          margin: const EdgeInsets.only(bottom: 16.0, top: 8.0),
                          padding: const EdgeInsets.all(16.0),
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
                              Text(
                                'Detalhes do pedido:\n${order.details}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                'Data do Pedido: ${order.dateString}',
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
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
