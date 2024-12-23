import 'package:flutter/material.dart';
import 'package:klitzke_orcamento/services/api_service.dart';

class CategoryRegisterPage extends StatefulWidget {
  @override
  _CategoryRegisterPageState createState() => _CategoryRegisterPageState();
}

class _CategoryRegisterPageState extends State<CategoryRegisterPage> {
  final TextEditingController categoryController = TextEditingController();
  final GetServices getServices = GetServices();
  final PostServices postServices = PostServices();

  String selectedType = 'Entrada';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  List<Map<String, dynamic>> getCategorys = [];

  void fetchCategories() async {
    try {
      final result = await getServices.getCategorys();
      setState(() {
        getCategorys = result;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar categorias')),
      );
    }
  }

  void registerCategory(BuildContext context) async {
    final category = categoryController.text.trim();

    if (category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha o nome da categoria!'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    bool success = await postServices.registerCategory(category, selectedType);

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Categoria cadastrada com sucesso!')),
      );
      categoryController.clear();
      fetchCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Nome da Categoria',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Tipo de Categoria',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue!;
                });
              },
              items: <String>['Entrada', 'Saída']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : () => registerCategory(context),
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
            const SizedBox(height: 24),
            Text(
              'Categorias Cadastradas',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: getCategorys.isEmpty
                  ? const Center(
                      child: Text('Nenhuma categoria cadastrada ainda'),
                    )
                  : ListView.builder(
                      itemCount: getCategorys.length,
                      itemBuilder: (context, index) {
                        final category = getCategorys[index];
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(
                              category['tipo'] == 'Entrada'
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: category['tipo'] == 'Entrada'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            title: Text(category['nome'] ??
                                'Sem nome'),
                            subtitle: Text(
                                'Tipo: ${category['tipo']}'),
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
}
