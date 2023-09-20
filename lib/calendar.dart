import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'new_order.dart';
import 'order.dart';
import 'orders_list_day.dart';
import 'package:intl/intl.dart';

Map<String, List<Order>> ordersByDate = {};

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  Map<String, List<Order>> ordersByDate = {};

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _createOrdersByDateMap();
  }

  void _createOrdersByDateMap() {
    // Preencha o mapa com os pedidos
    for (final order in allOrders) {
      final dateKey = DateFormat('yyyy-MM-dd').format(order.date);
      if (ordersByDate.containsKey(dateKey)) {
        ordersByDate[dateKey]!.add(order);
      } else {
        ordersByDate[dateKey] = [order];
      }
    }
  }

  void _showOrdersForDay(BuildContext context) {
    final dateKey = DateFormat('yyyy-MM-dd').format(_selectedDay);
    final ordersForDay = ordersByDate[dateKey] ?? [];

    if (ordersForDay.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OrderListPage(ordersForDay),
        ),
      );
    } else {
      // Se não houver pedidos, você pode exibir uma mensagem ou fazer outra ação apropriada
      // Por exemplo:
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sem pedidos'),
            content: Text('Não há pedidos para o dia selecionado.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Calendário'),
        backgroundColor: Colors.blue[800],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2023, 12, 31),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _showOrdersForDay(context);
              },
              eventLoader: (day) {
                final dateKey = DateFormat('yyyy-MM-dd').format(day);
                return ordersByDate[dateKey] ?? [];
              },
            ),
          ],
        ),
      ),
    );
  }
}
