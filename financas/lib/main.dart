import 'package:flutter/material.dart';
import 'package:klitzke_orcamento/data/http/http_client.dart';
import 'package:klitzke_orcamento/data/repositories/transacao_repository.dart';
import 'package:klitzke_orcamento/pages/accounts_page.dart';
import 'package:klitzke_orcamento/pages/category_page.dart';
import 'package:klitzke_orcamento/pages/createbudget_page.dart';
import 'package:klitzke_orcamento/pages/expenses_page.dart';
import 'package:klitzke_orcamento/pages/listTransacao_page.dart';
import 'package:klitzke_orcamento/pages/login_page.dart';
import 'package:klitzke_orcamento/pages/dashboard_page.dart';
import 'package:klitzke_orcamento/dio/api_client.dart';
import 'package:klitzke_orcamento/pages/profile_page.dart';
import 'package:klitzke_orcamento/pages/register_page.dart';
import 'package:klitzke_orcamento/layout/base_layout.dart';
import 'package:klitzke_orcamento/pages/settings_page.dart';
import 'package:klitzke_orcamento/pages/stores/transacao_sore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDio();
  runApp(const MyApp());
}

final transacaoStore = TransacaoStore(
  repository: TransacaoRepository(client: HttpClient()),
);

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
        '/budget': (context) => BaseLayout(body: CreatebudgetPage()),
        '/listtransacao': (context) => BaseLayout(
              body: ListTransacao(store: transacaoStore),
            ),
        '/settings': (context) => BaseLayout(body: SettingsPage()),
        '/profile': (context) => BaseLayout(body: ProfilePage()),
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
