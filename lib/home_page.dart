import 'package:dispmoveis/emoticons.dart';
import 'package:flutter/material.dart';
import 'package:dispmoveis/calendar.dart';
import 'package:dispmoveis/register.dart';
import 'package:dispmoveis/schedule.dart';
import 'package:dispmoveis/employees.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'customer.dart';
import 'customers_list.dart';
import 'register.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(minutes: 1), (Timer t) => updateDate());
  }

  void updateDate() {
    setState(() {
      currentDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bem-vindo, Fernando!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        DateFormat('dd MMM, yyyy').format(currentDate),
                        style: TextStyle(color: Colors.blue[200]),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
            ),

            // 4 ini options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // schedule
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SchedulePage(),
                    ));
                  },
                  child: Column(
                    children: [
                      Emoticon(
                        emoticon: '📦',
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Novo pedido',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),

                // calendar
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CalendarPage(),
                    ));
                  },
                  child: Column(
                    children: [
                      Emoticon(
                        emoticon: '🗓️',
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Calendário',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),

                // employees
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EmployeesPage(),
                    ));
                  },
                  child: Column(
                    children: [
                      Emoticon(
                        emoticon: '🤵',
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Funcionários',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 70,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Acesso rápido',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people,
                              color: Colors.grey[700],
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CustomersListPage(
                                      customers: allCustomers),
                                ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Lista de clientes',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${allCustomers.length} clientes',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
