import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/new_order.dart';
import '../models/order.dart';
import '../controllers/orders_list_day.dart';
import 'package:intl/intl.dart';

Map<String, List<Order>> ordersByDate = {};

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

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

  // Cria o mapa com os pedidos para serem exibidos no calendário
  void _createOrdersByDateMap() {
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
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Sem pedidos'),
            content: const Text('Não há pedidos para o dia selecionado.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
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
