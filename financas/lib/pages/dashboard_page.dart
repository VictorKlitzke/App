import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:klitzke_orcamento/layout/base_layout.dart';
import 'package:klitzke_orcamento/services/api_service.dart';
import '../components/siderbar_components.dart';

class DashboardPage extends StatefulWidget {
  @override
  _FinancialDashboardPageState createState() => _FinancialDashboardPageState();
}

class _FinancialDashboardPageState extends State<DashboardPage> {
  final GetServices getServices = GetServices();

  List<Map<String, dynamic>> getTransitions = [];
  List<Map<String, dynamic>> transacoesRecentes = [];

  double saldoAtual = 0.0;
  double totalReceitas = 0.0;
  double totalDespesas = 0.0;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
    fetchRecentes();
  }

  void fetchRecentes() async {
    try {
      final result = await getServices.getTransition();
      setState(() {
        transacoesRecentes = result
            .map((item) => {
                  'Descrição': item['descricao'] ?? 'Sem descrição',
                  'Data': item['data_transacao'] ?? 'Data desconhecida',
                  'Valor': item['valor']?.toString() ?? '0.00',
                })
            .take(4)
            .toList();
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao tentar buscar transações recentes!'),
        ),
      );
    }
  }

  void fetchTransactions() async {
    try {
      final result = await getServices.getTransition();

      double saldoTemp = 0.0;
      double receitasTemp = 0.0;
      double despesasTemp = 0.0;

      setState(() {
        getTransitions = result
            .map((item) => {
                  'id': item['id'] ?? '0',
                  'Descrição': item['descricao'] ?? 'Sem descrição',
                  'Data': item['data_transacao'] ?? 'Data desconhecida',
                  'valor': item['valor'] ?? '0',
                  'tipo': item['tipo'] ?? 'entrada',
                })
            .toList();

        for (var item in result) {
          double valor = double.tryParse(item['valor']
                  .toString()
                  .replaceAll(',', '')
                  .replaceAll('.', '')) ??
              0.0;
          if (item['tipo'] == 'Entrada') {
            receitasTemp = valor;
          } else if (item['tipo'] == 'Saída') {
            despesasTemp = valor;
          } else {
            saldoTemp = valor;
          }
        }
        saldoAtual = saldoTemp;
        totalReceitas = receitasTemp;
        totalDespesas = despesasTemp;

        print(transacoesRecentes);
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao tentar buscar informações para o dashboard!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildCards(),
            const SizedBox(height: 30),
            _buildChartSection(),
            const SizedBox(height: 30),
            _buildRecentTransactions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      'Resumo Financeiro',
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCard('Saldo Atual', 'R\$ ${saldoAtual.toStringAsFixed(2)}',
              Colors.teal),
          _buildCard('Receitas', 'R\$ ${totalReceitas.toStringAsFixed(2)}',
              Colors.green),
          _buildCard('Despesas', 'R\$ ${totalDespesas.toStringAsFixed(2)}',
              Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Receitas vs Despesas',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20000,
              barGroups: [
                _buildBarChartGroupData(0, totalReceitas, Colors.green),
                _buildBarChartGroupData(1, totalDespesas, Colors.redAccent),
              ],
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 0:
                            return const Text('Receitas');
                          case 1:
                            return const Text('Despesas');
                        }
                        return const Text('');
                      }),
                ),
                leftTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData _buildBarChartGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 24,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transações Recentes',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: transacoesRecentes.map((transacao) {
            final descricao = transacao["descricao"] ?? 'Sem descrição';
            final data = transacao["data_transacao"] ?? 'Data desconhecida';
            final valor = transacao["valor"] != null
                ? transacao["valor"].toString()
                : 'R\$ 0,00'; // Conversão explícita para String

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  descricao,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Data: $data'),
                trailing: Text(
                  'R\$ $valor',
                  style: TextStyle(
                    color: valor.contains('-') ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
