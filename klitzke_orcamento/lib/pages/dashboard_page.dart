import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  void logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Criar Orçamento'),
              onTap: () {
                Navigator.pushNamed(context, '/orcamento');
              },
            ),
            const Divider(),  // Adiciona uma linha divisória entre as opções
            ListTile(
              title: const Text('Sair'),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Bem-vindo à Dashboard!')),
    );
  }
}
