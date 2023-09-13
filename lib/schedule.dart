import 'package:dispmoveis/home_page.dart';
import 'package:flutter/material.dart';
import 'package:dispmoveis/register.dart';

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
        title: Text('Novo pedido'),
        backgroundColor: Colors.blue[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
          },
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '📦',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 72,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),

              // Opção: Novo Cliente
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ));
                },
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
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

              SizedBox(height: 20),

              // Opção: Cliente já cadastrado
              GestureDetector(
                onTap: () {
                  // Implementar novo pedido
                },
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
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
