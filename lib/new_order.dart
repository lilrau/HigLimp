import 'package:flutter/material.dart';
import 'register.dart';
import 'customer.dart';
import 'order.dart';
import 'package:intl/intl.dart';

Customer? selectedCustomer;

class NewOrderPage extends StatefulWidget {
  const NewOrderPage({super.key});

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pedido para cliente cadastrado'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
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
                decoration: InputDecoration(
                  labelText: 'Selecione um cliente',
                ),
              ),
              if (selectedCustomer != null) ...[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nome do Pedido'),
                  // alidação para o nome do pedido
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Preço do Pedido'),
                  // alidação para o preço do pedido
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Data do Pedido'),
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
                ElevatedButton(
                  onPressed: () {
                    if (selectedCustomer != null) {
                      final newOrder = Order(
                        name: _nameController.text,
                        price: _priceController.text,
                        date: DateTime.parse(_dateController.text),
                      );

                      selectedCustomer!.orders.add(newOrder);

                      _nameController.clear();
                      _priceController.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Pedido registrado com sucesso!'),
                        ),
                      );
                    }
                  },
                  child: Text('Registrar Pedido'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
