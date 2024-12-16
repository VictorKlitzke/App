import 'package:flutter/material.dart';
import 'package:klitzke_orcamento/pages/accounts_page.dart';
import 'package:klitzke_orcamento/pages/category_page.dart';
import 'package:klitzke_orcamento/pages/expenses_page.dart';
import 'package:klitzke_orcamento/pages/login_page.dart';
import 'package:klitzke_orcamento/pages/dashboard_page.dart';
import 'package:klitzke_orcamento/dio/api_client.dart';
import 'package:klitzke_orcamento/pages/register_page.dart';

void main() {
  configureDio();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Klitzke',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
        '/register': (context) => RegisterPage(),
        '/category': (context) => CategoryRegisterPage(),
        '/expense': (context) => ExpensesPage(),
        '/accounts': (context) => AccountsRegisterPage()
      },
    );
  }
}
