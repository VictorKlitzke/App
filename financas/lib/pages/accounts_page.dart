import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:klitzke_orcamento/services/api_service.dart';

class MoneyInputFormatter extends TextInputFormatter {
  final NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.isEmpty) return newValue;

    final number = int.tryParse(text);
    if (number == null) return newValue;

    final formatted = formatter.format(number / 100);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class AccountsRegisterPage extends StatefulWidget {
  @override
  _AccountsRegisterPage createState() => _AccountsRegisterPage();
}

class _AccountsRegisterPage extends State<AccountsRegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();

  final PostServices postServices = PostServices();
  final GetServices getServices = GetServices();

  bool isLoading = false;
  List<Map<String, dynamic>> getAccounts = [];

  @override
  void initState() {
    super.initState();
    fetchAccounts(); // Carrega as contas ao inicializar a página
  }

  void fetchAccounts() async {
    try {
      final result = await getServices.getAccounts();
      setState(() {
        getAccounts = result;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar contas')),
      );
    }
  }

  void registerAccounts(BuildContext context) async {
    final account = nameController.text.trim();
    final balance = balanceController.text
        .trim()
        .replaceAll(',', '.')
        .replaceAll('R\$', '');

    if (account.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta está vazio, preencha por favor!')),
      );
      return;
    } else if (balance.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Saldo inicial está vazio, preencha por favor!')),
      );
      return;
    } else if (account.isEmpty && balance.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Campos estão vazios, preencha por favor!')),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      bool success = await postServices.registerAccounts(account, balance);
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        isLoading = false;
      });
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Conta criada com sucesso')),
        );
        nameController.clear();
        balanceController.clear();
        fetchAccounts();
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao autenticar registro de contas')),
      );
    }
  }

  @override
  Widget build(BuildContext content) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Conta'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome da Conta',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            buildTextField(
              'Nome da Conta',
              nameController,
              TextInputType.text,
            ),
            const SizedBox(height: 16),
            Text(
              'Saldo Inicial',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            buildMoneyField(
              'Saldo Inicial',
              balanceController,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : () => registerAccounts(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Categorias Cadastradas',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: getAccounts.length,
                itemBuilder: (context, index) {
                  final account = getAccounts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(account['nome'] ?? 'Conta Desconhecida'),
                      subtitle: Text(
                        'Saldo: ${account['saldo_inicial'] ?? 'R\$0.00'}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMoneyField(
    String label,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [MoneyInputFormatter()],
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      TextInputType keyboardType) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepPurple),
        ),
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
    );
  }
}
