import 'package:flutter/material.dart';
import 'package:klitzke_orcamento/pages/login_page.dart';
import 'package:klitzke_orcamento/pages/dashboard_page.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Orçamentos App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}
