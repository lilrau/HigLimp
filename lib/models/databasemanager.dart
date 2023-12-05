import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../controllers/new_employee.dart';
import '../controllers/register.dart';
import 'customer.dart';
import 'employee.dart';

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._internal();
  Database? _database;

  factory DatabaseManager() {
    return _instance;
  }

  DatabaseManager._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE "customers" (
        "id" INTEGER,
        "name" TEXT,
        "phone" TEXT,
        "address" TEXT,
        "email" TEXT,
        PRIMARY KEY("id")
      );
    ''');

    await db.execute('''
      CREATE TABLE "customer_orders" (
        "id" INTEGER,
        "customer_id" INTEGER,
        "order_id" INTEGER,
        FOREIGN KEY("order_id") REFERENCES "orders"("id"),
        FOREIGN KEY("customer_id") REFERENCES "customers"("id"),
        PRIMARY KEY("id")
      );
    ''');

    await db.execute('''
      CREATE TABLE "employee_orders" (
        "id" INTEGER,
        "employee_id" INTEGER,
        "order_id" INTEGER,
        FOREIGN KEY("order_id") REFERENCES "orders"("id"),
        FOREIGN KEY("employee_id") REFERENCES "employees"("id"),
        PRIMARY KEY("id")
      );
    ''');

    await db.execute('''
      CREATE TABLE "employees" (
        "id" INTEGER,
        "name" TEXT,
        "phone" TEXT,
        PRIMARY KEY("id")
      );
    ''');

    await db.execute('''
      CREATE TABLE "orders" (
        "id" INTEGER,
        "name" TEXT,
        "date" TEXT,
        "details" TEXT,
        PRIMARY KEY("id")
      );
    ''');
  }

  // Método para inserir um novo pedido
  Future<int> insertOrder(Map<String, dynamic> orderData) async {
    final db = await database;
    return await db.insert('orders', orderData);
  }

  // Método para obter todos os pedidos
  Future<List<Map<String, dynamic>>> getOrders() async {
    final db = await database;
    return await db.query('orders');
  }

  // Método para obter um pedido específico por ID
  Future<Map<String, dynamic>?> getOrderById(int orderId) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db.query('orders', where: 'id = ?', whereArgs: [orderId]);

    return result.isNotEmpty ? result.first : null;
  }

  // Método para atualizar um pedido existente
  Future<int> updateOrder(Map<String, dynamic> orderData) async {
    final db = await database;
    return await db.update('orders', orderData,
        where: 'id = ?', whereArgs: [orderData['id']]);
  }

  // Método para excluir um pedido por ID
  Future<int> deleteOrder(int orderId) async {
    final db = await database;
    return await db.delete('orders', where: 'id = ?', whereArgs: [orderId]);
  }

  // Método para inserir um novo funcionário
  Future<int> insertEmployee(Map<String, dynamic> employeeData) async {
    final db = await database;
    return await db.insert('employees', employeeData);
  }

  // Método para obter todos os funcionários
  Future<List<Map<String, dynamic>>> getEmployees() async {
    final db = await database;
    return await db.query('employees');
  }

  // Método para obter um funcionário específico por ID
  Future<Map<String, dynamic>?> getEmployeeById(int employeeId) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db.query('employees', where: 'id = ?', whereArgs: [employeeId]);

    return result.isNotEmpty ? result.first : null;
  }

  // Método para atualizar um funcionário existente
  Future<int> updateEmployee(Map<String, dynamic> employeeData) async {
    final db = await database;
    return await db.update('employees', employeeData,
        where: 'id = ?', whereArgs: [employeeData['id']]);
  }

  // Método para excluir um funcionário por ID
  Future<int> deleteEmployee(int employeeId) async {
    final db = await database;
    return await db
        .delete('employees', where: 'id = ?', whereArgs: [employeeId]);
  }

  // Método para inserir um novo cliente
  Future<int> insertCustomer(Map<String, dynamic> customerData) async {
    final db = await database;
    return await db.insert('customers', customerData);
  }

  // Método para obter todos os clientes
  Future<List<Map<String, dynamic>>> getCustomers() async {
    final db = await database;
    return await db.query('customers');
  }

  // Método para obter um cliente específico por ID
  Future<Map<String, dynamic>?> getCustomerById(int customerId) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db.query('customers', where: 'id = ?', whereArgs: [customerId]);

    return result.isNotEmpty ? result.first : null;
  }

  // Método para atualizar um cliente existente
  Future<int> updateCustomer(Map<String, dynamic> customerData) async {
    final db = await database;
    return await db.update('customers', customerData,
        where: 'id = ?', whereArgs: [customerData['id']]);
  }

  // Método para excluir um cliente por ID
  Future<int> deleteCustomer(int customerId) async {
    final db = await database;
    return await db
        .delete('customers', where: 'id = ?', whereArgs: [customerId]);
  }

  // Método para associar um pedido a um cliente
  Future<int> associateOrderWithCustomer(
      Map<String, dynamic> customerOrderData) async {
    final db = await database;
    return await db.insert('customer_orders', customerOrderData);
  }

  // Método para obter todos os pedidos associados a um cliente
  Future<List<Map<String, dynamic>>> getCustomerOrders(int customerId) async {
    final db = await database;
    return await db.query('customer_orders',
        where: 'customer_id = ?', whereArgs: [customerId]);
  }

  // Método para associar um pedido a um funcionário
  Future<int> associateOrderWithEmployee(
      Map<String, dynamic> employeeOrderData) async {
    final db = await database;
    return await db.insert('employee_orders', employeeOrderData);
  }

  // Método para obter todos os pedidos associados a um funcionário
  Future<List<Map<String, dynamic>>> getEmployeeOrders(int employeeId) async {
    final db = await database;
    return await db.query('employee_orders',
        where: 'employee_id = ?', whereArgs: [employeeId]);
  }

  static void createDatabase() async {
    allCustomers.add(Customer(
        name: 'João',
        phone: '11996246365',
        address: 'Rua Pindamonhangaba, 123',
        email: 'joao@gmail.com',
        orders: []));

    allCustomers.add(Customer(
        name: 'Ana',
        phone: '11996246365',
        address: 'Rua Pindamonhangaba, 894',
        email: 'ana@gmail.com',
        orders: []));

    allEmployees.add(Employee(name: 'Maria', phone: '11997672322', orders: []));

    allEmployees.add(Employee(name: 'Pedro', phone: '11997672322', orders: []));
  }

  Future<void> closeDatabase() async {
    final db = await database;
    db.close();
  }
}
