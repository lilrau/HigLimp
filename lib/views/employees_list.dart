import 'package:flutter/material.dart';
import '../models/employee.dart';
import 'package:intl/intl.dart';

class EmployeesListPage extends StatefulWidget {
  final List<Employee> employees;

  const EmployeesListPage({
    Key? key,
    required this.employees,
  }) : super(key: key);

  @override
  _EmployeesListPageState createState() => _EmployeesListPageState();
}

class _EmployeesListPageState extends State<EmployeesListPage> {
  List<bool> _showDetails =
  List.filled(100, false); // Assume um limite máximo de 100 funcionários

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Lista de funcionários'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView.builder(
        itemCount: widget.employees.length,
        itemBuilder: (context, index) {
          final employee = widget.employees[index];
          return Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      employee.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Text('Telefone: ${employee.phone}'),
                    trailing: Text('Comissão: R\$${employee.value}'),
                  ),
                  const Divider(),
                  Visibility(
                    visible: _showDetails[index],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              DateFormat('yyyy/MM/dd HH:mm')
                                  .format(order.date);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nome do Pedido: ${order.name}'),
                                  Text('Preço do Pedido: R\$${order.price}'),
                                  Text(
                                      'Detalhes do pedido: \n${order.details}'),
                                  Text('Data do Pedido: $formattedDate'),
                                  const SizedBox(height: 8.0),
                                  const Divider(),
                                  const SizedBox(height: 8.0),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showDetails[index] = !_showDetails[index];
                        });
                      },
                      child: Text(_showDetails[index]
                          ? 'Ocultar Detalhes'
                          : 'Mostrar Detalhes'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}