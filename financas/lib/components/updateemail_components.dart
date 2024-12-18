import 'package:flutter/material.dart';
import 'package:klitzke_orcamento/services/api_service.dart';

class UpdateEmailComponents extends StatefulWidget {
  @override
  _UpdateEmailComponentsState createState() => _UpdateEmailComponentsState();
}

class _UpdateEmailComponentsState extends State<UpdateEmailComponents> {
  final TextEditingController currentEmailController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  PutServices putServices = PutServices();

  bool isLoading = false;

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Map<String, String>? validateAndGetPasswords(BuildContext context) {

    final currentemail = currentEmailController.text;
    final newemail = newEmailController.text;

    if (currentemail.isEmpty) {
       _showSnackBar(context, 'Email atual está com o campo vazio!');
      return null;
    } else if (newemail.isEmpty) {
       _showSnackBar(context, 'Novo email está com o campo vazio!');
      return null;
    }

    if (currentemail == newemail) {
       _showSnackBar(context, 'Email atual igual ao email novo!');
      return null;
    }

    return {
      currentemail: currentemail,
      newemail: newemail
    };
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Atualizar E-mail',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0066CC),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: currentEmailController,
              decoration: const InputDecoration(
                labelText: 'E-mail Atual',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newEmailController,
              decoration: const InputDecoration(
                labelText: 'Novo E-mail',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
