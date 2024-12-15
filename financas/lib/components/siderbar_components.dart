import 'package:klitzke_orcamento/dio/api_client.dart';
import 'package:flutter/material.dart';

class SiderBarComponents extends StatelessWidget {
void logout(BuildContext context) async {
  try {
    final response = await dio.post('logout');

    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao tentar sair do aplicativo'),
        ),
      );
    }
  } catch (error) {
    print('Erro ao fazer logout: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Erro ao tentar sair do aplicativo'),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
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
              title: const Text('Criar Orçamento'),
              onTap: () {
                Navigator.pushNamed(context, '/orcamento');
              },
            ),
            ListTile(
              title: const Text('Categorias'),
              onTap: () {
                Navigator.pushNamed(context, '/category');
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Sair'),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
