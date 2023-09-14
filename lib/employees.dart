import 'package:flutter/material.dart';
import 'customer.dart';
import 'register.dart';

void printFirstCustomerOrders(List<Customer> customers) {
  if (customers.isNotEmpty) {
    final firstCustomer = customers[0];
    print('Pedidos do primeiro cliente:');
    for (var order in firstCustomer.orders) {
      print('Nome do Pedido: ${order.name}');
      print('Preço do Pedido: ${order.price}');
      print('Data do Pedido: ${order.date}');
    }
  } else {
    print('A lista de clientes está vazia.');
  }
}

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  @override
  Widget build(BuildContext context) {
    printFirstCustomerOrders(allCustomers);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Funcionários'),
        backgroundColor: Colors.blue[800],
      ),
    );
  }
}
