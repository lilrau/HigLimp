import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/customer.dart';
import 'package:intl/intl.dart';

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
  void _callCustomer(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Lista de clientes'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView.builder(
        itemCount: widget.customers.length,
        itemBuilder: (context, index) {
          final customer = widget.customers[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: ExpansionTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      customer.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      _callCustomer(customer.phone);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 8.0),
                        Text('Ligar para cliente'),
                      ],
                    ),
                  ),
                  Text(
                    'Telefone: ${customer.phone}',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    'Endereço: ${customer.address}   Email: ${customer.email}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Pedidos:'),
                      const SizedBox(height: 8.0),
                      ...customer.orders.map((order) {
                        final formattedDate =
                        DateFormat('yyyy/MM/dd HH:mm').format(order.date);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetail('Nome do Pedido', order.name),
                            _buildDetail(
                                'Preço do Pedido', 'R\$${order.price}'),
                            _buildDetail('Detalhes do Pedido', order.details),
                            _buildDetail('Data do Pedido', formattedDate),
                            const SizedBox(height: 8.0),
                            const Divider(color: Colors.grey),
                            const SizedBox(height: 8.0),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetail(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          content,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );
  }
}