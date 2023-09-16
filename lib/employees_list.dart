import 'package:flutter/material.dart';
import 'employee.dart';
import 'package:intl/intl.dart';

class EmployeesListPage extends StatefulWidget {
  final List<Employee> employees;

  const EmployeesListPage({
    Key? key,
    required this.employees,
  }) : super(key: key);

  @override
  State<EmployeesListPage> createState() => _EmployeesListPageState();
}

class _EmployeesListPageState extends State<EmployeesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Lista de clientes'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView.builder(
        itemCount: widget.employees.length,
        itemBuilder: (context, index) {
          final employee = widget.employees[index];
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
                  employee.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text('Telefone: ${employee.phone}'),
                Text('Comissão: R\$${employee.value}'),
                const SizedBox(height: 8.0),
                const Text(
                  'Pedidos:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: employee.orders.map((order) {
                    final formattedDate =
                        DateFormat('yyyy-MM-dd HH:mm').format(order.date);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nome do Pedido: ${order.name}'),
                        Text('Preço do Pedido: R\$${order.price}'),
                        Text('Data do Pedido: $formattedDate'),
                        const Text(
                            '----------------------------------------------------------'),
                        const SizedBox(height: 8.0),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
