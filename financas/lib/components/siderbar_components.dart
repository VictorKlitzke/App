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
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.blue,
            border: Border(bottom: BorderSide(color: Colors.white)),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   radius: 30,
                //   backgroundImage: NetworkImage(
                //     '',
                //   ),
                // ),
                const SizedBox(height: 10),
                const Text(
                  'Nome do Usuário',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'email@exemplo.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        // ListTile(
        //   leading: const Icon(Icons.add),
        //   title: const Text('Criar Orçamento'),
        //   onTap: () {
        //     Navigator.pop(context);
        //     Navigator.pushNamed(context, '/orcamento');
        //   },
        // ),
        ListTile(
          leading: const Icon(Icons.category),
          title: const Text('Categorias'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/category');
          },
        ),
        ListTile(
            leading: const Icon(Icons.account_balance_outlined),
            title: const Text('Contas'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/accounts');
            }),
        ListTile(
            leading: const Icon(Icons.expand),
            title: const Text('Despesas'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/expense');
            }),
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
