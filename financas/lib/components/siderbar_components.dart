import 'package:klitzke_orcamento/dio/api_client.dart';
import 'package:flutter/material.dart';

class SiderBarComponents extends StatelessWidget {
  void logout(BuildContext context) async {
    try {
      final response = await dio.post('logout');

      print(' Logout: $response');

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
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Menu',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Criar Orçamento'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/orcamento');
          },
        ),
        ListTile(
          leading: const Icon(Icons.category),
          title: const Text('Categorias'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/category');
          },
        ),
        ListTile(
          leading: const Icon(Icons.expand),
          title: const Text('Despesas'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/expenses');
          }
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Sair'),
          onTap: () {
            Navigator.pop(context);
            logout(context);
          },
        ),
      ],
    );
  }
}
