import 'package:flutter/material.dart';
import 'register.dart';
import 'customer.dart';

class CustomersListPage extends StatefulWidget {
  final List<Customer> customers;

  const CustomersListPage({
    Key? key,
    required this.customers,
  }) : super(key: key);

  @override
  State<CustomersListPage> createState() => _CustomersListPageState();
}

class _CustomersListPageState extends State<CustomersListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Lista de clientes'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView.builder(
        itemCount: widget.customers.length,
        itemBuilder: (context, index) {
          final customer = widget.customers[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.only(bottom: 16.0, top: 8.0),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text('Telefone: ${customer.phone}'),
                Text('Endereço: ${customer.address}'),
                Text('Email: ${customer.email}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
