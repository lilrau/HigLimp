import 'package:flutter/material.dart';
import 'order.dart';
import 'new_order.dart';
import 'package:intl/intl.dart';
import 'register.dart';
import 'new_employee.dart';

class EditOrderPage extends StatefulWidget {
  final Order order;

  const EditOrderPage({required this.order});

  @override
  _EditOrderPageState createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _priceController.text = widget.order.price;
    _detailsController.text = widget.order.details;
    _dateController.text =
        DateFormat('yyyy-MM-dd HH:mm').format(widget.order.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Pedido - ${widget.order.name}'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Preço do Pedido'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _detailsController,
                decoration:
                    const InputDecoration(labelText: 'Detalhes do Pedido'),
                maxLines: null,
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
              ElevatedButton(
                onPressed: () {
                  final updatedOrder = Order(
                    name: widget.order.name, // Mantém o mesmo nome
                    price: _priceController.text,
                    details: _detailsController.text,
                    date: DateTime.parse(_dateController.text),
                  );

                  widget.order.updateOrder(
                    price: updatedOrder.price,
                    details: updatedOrder.details,
                    date: updatedOrder.date,
                  );

                  // Atualize a lista de pedidos em todos os clientes e funcionários.
                  for (final customer in allCustomers) {
                    final orderIndex = customer.orders.indexOf(widget.order);
                    if (orderIndex != -1) {
                      customer.orders[orderIndex] = widget.order;
                    }
                  }

                  for (final employee in allEmployees) {
                    final orderIndex = employee.orders.indexOf(widget.order);
                    if (orderIndex != -1) {
                      employee.orders[orderIndex] = widget.order;
                      employee.calculateValue();
                    }
                  }

                  // Atualize a lista de todos os pedidos.
                  final orderIndex = allOrders.indexOf(widget.order);
                  if (orderIndex != -1) {
                    allOrders[orderIndex] = widget.order;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pedido atualizado com sucesso!'),
                    ),
                  );

                  Navigator.pop(context, widget.order);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                ),
                child: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
