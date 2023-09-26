import 'package:dispmoveis/views/home_page.dart';
import 'package:flutter/material.dart';
import '../models/employee.dart';

List<Employee> allEmployees = [];

class NewEmployeesPage extends StatefulWidget {
  const NewEmployeesPage({super.key});

  @override
  State<NewEmployeesPage> createState() => _NewEmployeesPageState();
}

class _NewEmployeesPageState extends State<NewEmployeesPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Adicionar funcionários'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  } else if (!nameRegex.hasMatch(value)) {
                    return 'Nome só aceita letras e espaços';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Celular'),
                validator: (value) {
                  final phoneRegex = RegExp(r'^\d{10,12}$');
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número de celular';
                  } else if (!phoneRegex.hasMatch(value)) {
                    return 'Celular só aceita números e deve ter entre 10 e 12 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newEmployee = Employee(
                        name: _nameController.text,
                        phone: _phoneController.text,
                        orders: []);

                    allEmployees.add(newEmployee);

                    _nameController.clear();
                    _phoneController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cliente registrado com sucesso!'),
                      ),
                    );

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                ),
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
