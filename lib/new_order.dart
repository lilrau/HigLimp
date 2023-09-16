import 'package:dispmoveis/new_employee.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'customer.dart';
import 'order.dart';
import 'employee.dart';
import 'package:intl/intl.dart';

Customer? selectedCustomer;
Employee? selectedEmployee;

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
        title: const Text('Pedido para cliente cadastrado'),
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
              decoration: const InputDecoration(
                labelText: 'Selecione um cliente',
              ),
            ),
            if (selectedCustomer != null) ...[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome do Pedido'),
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Preço do Pedido'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Data do Pedido'),
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
                onPressed: () {
                  if (selectedCustomer != null && selectedEmployee != null) {
                    final newOrder = Order(
                      name: _nameController.text,
                      price: _priceController.text,
                      date: DateTime.parse(_dateController.text),
                    );

                    selectedCustomer!.orders.add(newOrder);
                    selectedEmployee!.orders.add(newOrder);
                    selectedEmployee!.calculateValue();

                    _nameController.clear();
                    _priceController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pedido registrado com sucesso!'),
                      ),
                    );
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
              )
            ],
          ],
        )),
      ),
    );
  }
}
