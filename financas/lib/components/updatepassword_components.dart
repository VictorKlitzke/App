import 'package:flutter/material.dart';

class UpdatePasswordComponents extends StatefulWidget {
  @override
  _UpdatePasswordComponents createState() => _UpdatePasswordComponents();
}

class _UpdatePasswordComponents extends State<UpdatePasswordComponents> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void Textfields() {
    final currentPassword = currentPasswordController.text;
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (currentPassword.isEmpty) {
      _showSnackBar(context, 'Senha atual está com o campo vazio!');
      return;
    }

    if (newPassword != confirmPassword) {
      _showSnackBar(
          context, 'Nova senha e confirmação de senha não coincidem!');
      return;
    }

    if (currentPassword == newPassword) {
      _showSnackBar(context, 'A nova senha não pode ser igual à senha atual!');
      return;
    }

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showSnackBar(context, 'Por favor, preencha todos os campos de senha!');
      return;
    }
  }

  void updatepassword(BuildContext context) async {
    Textfields();
    try {} catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alterar Senha',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0066CC),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha Atual',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Nova Senha',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Nova Senha',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
