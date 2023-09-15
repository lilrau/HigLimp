import 'package:flutter/material.dart';
import 'employee.dart';

List<Employee> allEmployees = [];

class NewEmployeesPage extends StatefulWidget {
  const NewEmployeesPage({super.key});

  @override
  State<NewEmployeesPage> createState() => _NewEmployeesPageState();
}

class _NewEmployeesPageState extends State<NewEmployeesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Adicionar funcionários'),
        backgroundColor: Colors.blue[800],
      ),
    );
  }
}
