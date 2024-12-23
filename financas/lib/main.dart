import 'package:flutter/material.dart';
import 'package:klitzke_orcamento/pages/accounts_page.dart';
import 'package:klitzke_orcamento/pages/category_page.dart';
import 'package:klitzke_orcamento/pages/expenses_page.dart';
import 'package:klitzke_orcamento/pages/login_page.dart';
import 'package:klitzke_orcamento/pages/dashboard_page.dart';
import 'package:klitzke_orcamento/dio/api_client.dart';
import 'package:klitzke_orcamento/pages/profile_page.dart';
import 'package:klitzke_orcamento/pages/register_page.dart';
import 'package:klitzke_orcamento/layout/base_layout.dart';
import 'package:klitzke_orcamento/pages/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klitzke',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/dashboard': (context) => DashboardPage(),
        '/settings': (context) => BaseLayout(
            body: SettingsPage()
          ),
        '/profile': (context) => BaseLayout(
            body: ProfilePage()
          ),
        '/category': (context) => BaseLayout(
              body: CategoryRegisterPage(),
            ),
        '/expense': (context) => BaseLayout(
              body: ExpensesPage(),
            ),
        '/accounts': (context) => BaseLayout(
              body: AccountsRegisterPage(),
            ),
      },
    );
  }
}
