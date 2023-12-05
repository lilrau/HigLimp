import 'new_employee.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import '../models/customer.dart';
import '../models/order.dart';
import '../models/employee.dart';
import '../views/home_page.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

Customer? selectedCustomer;
Employee? selectedEmployee;
List<Order> allOrders = [];
List<Order> waitingOrders = [];

class NewOrderPage extends StatefulWidget {
  const NewOrderPage({Key? key});

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  int stringToTimestamp() {
    String dateString = _dateController.text;
    final format = DateFormat('yyyy-MM-dd HH:mm');
    final date = format.parse(dateString);
    return date.millisecondsSinceEpoch ~/ 1000;
  }

  Future<bool> willRain() async {
    double lat = -25.0916;
    double lon = -50.1668;
    String apiKey = '022a143d4990bf04d8b79c5e978466bf';

    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final rainData = data['weather'][0]["main"] == "Rain" ? true : false;
      return rainData;
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pedido para cliente cadastrado'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                DropdownButtonFormField<Customer>(
                  value: selectedCustomer,
                  onChanged: (customer) {
                    setState(() {
                      selectedCustomer = customer;
                    });
                  },
                  items: allCustomers.map((customer) {
                    return DropdownMenuItem<Customer>(
                      value: customer,
                      child: Text(customer.name),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Selecione um cliente',
                  ),
                ),
                if (selectedCustomer != null) ...[
                  TextFormField(
                    controller: _nameController,
                    decoration:
                    const InputDecoration(labelText: 'Nome do Pedido'),
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration:
                    const InputDecoration(labelText: 'Preço do Pedido'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o preço do pedido.';
                      }
                      final price = double.tryParse(value);
                      if (price == null || price <= 0) {
                        return 'O preço deve ser um valor numérico maior que zero.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _detailsController,
                    decoration:
                    const InputDecoration(labelText: 'Detalhes do Pedido'),
                    maxLines: null, // Permite várias linhas para os detalhes
                  ),
                  TextFormField(
                    decoration:
                    const InputDecoration(labelText: 'Data do Pedido'),
                    readOnly: true,
                    controller: _dateController,
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (selectedDate != null) {
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        final selectedDateTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime!.hour,
                          selectedTime.minute,
                        );

                        setState(() {
                          _dateController.text = DateFormat('yyyy-MM-dd HH:mm')
                              .format(selectedDateTime);
                        });
                      }
                    },
                  ),
                  DropdownButtonFormField<Employee>(
                    value: selectedEmployee,
                    onChanged: (employee) {
                      setState(() {
                        selectedEmployee = employee;
                      });
                    },
                    items: allEmployees.map((employee) {
                      return DropdownMenuItem<Employee>(
                        value: employee,
                        child: Text(employee.name),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Funcionário',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (selectedCustomer != null &&
                          selectedEmployee != null) {
                        if (_dateController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                              Text('Por favor, preencha a data do pedido.'),
                            ),
                          );
                        } else {
                          var rain = await willRain();
                          if (!rain) {
                            final newOrder = Order(
                              name: _nameController.text,
                              price: _priceController.text,
                              details: _detailsController.text,
                              date: DateTime.parse(_dateController.text),
                            );

                            selectedCustomer!.orders.add(newOrder);
                            selectedEmployee!.orders.add(newOrder);
                            selectedEmployee!.calculateValue();
                            allOrders.add(newOrder);
                            waitingOrders.add(newOrder);

                            _nameController.clear();
                            _priceController.clear();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pedido registrado com sucesso!'),
                              ),
                            );

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                          } else {
                            final newOrder = Order(
                              name: _nameController.text,
                              price: _priceController.text,
                              details: _detailsController.text,
                              date: DateTime.parse(_dateController.text),
                            );

                            selectedCustomer!.orders.add(newOrder);
                            selectedEmployee!.orders.add(newOrder);
                            selectedEmployee!.calculateValue();
                            allOrders.add(newOrder);
                            waitingOrders.add(newOrder);

                            _nameController.clear();
                            _priceController.clear();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                Text('OBS: Previsão de clima inadequedo !'),
                              ),
                            );

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                          }
                          ;
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                    ),
                    child: const Text('Registrar Pedido'),
                  ),
                  const SizedBox(height: 50.0),
                  if (selectedCustomer!.orders.isNotEmpty)
                    Text(
                      'Pedidos de ${selectedCustomer!.name}:',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  const SizedBox(height: 20.0),
                  Container(
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: selectedCustomer!.orders.length,
                      itemBuilder: (context, index) {
                        final order = selectedCustomer!.orders[index];
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
                                'Data do Pedido: ${DateFormat('yyyy-MM-dd HH:mm').format(order.date)}',
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
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}