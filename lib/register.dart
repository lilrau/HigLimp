import 'package:flutter/material.dart';
import 'customer.dart';
import 'schedule.dart';

List<Customer> allCustomers = [];

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cadastrar cliente'),
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
                keyboardType: TextInputType.number,
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
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Endereço'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o endereço';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  final emailRegex =
                      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  } else if (!emailRegex.hasMatch(value)) {
                    return 'Email não está no formato correto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newCustomer = Customer(
                        name: _nameController.text,
                        phone: _phoneController.text,
                        address: _addressController.text,
                        email: _emailController.text,
                        orders: []);

                    allCustomers.add(newCustomer);

                    _nameController.clear();
                    _phoneController.clear();
                    _addressController.clear();
                    _emailController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cliente registrado com sucesso!'),
                      ),
                    );

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SchedulePage(),
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
