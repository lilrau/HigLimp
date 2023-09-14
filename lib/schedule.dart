import 'home_page.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'new_order.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Novo pedido'),
        backgroundColor: Colors.blue[800],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
          },
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '📦',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 72,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // Opção: Novo Cliente
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ));
                },
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: ListTile(
                    title: Text(
                      'Novo cliente',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Opção: Cliente já cadastrado
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NewOrderPage(),
                  ));
                },
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: ListTile(
                    title: Text(
                      'Cliente já cadastrado',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
