import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../components/siderbar_components.dart';

class DashboardPage extends StatefulWidget {
  @override
  _FinancialDashboardPageState createState() => _FinancialDashboardPageState();
}

class _FinancialDashboardPageState extends State<DashboardPage> {
  final double saldoAtual = 12000.00;
  final double totalReceitas = 18500.00;
  final double totalDespesas = 6500.00;

  final List<Map<String, String>> transacoesRecentes = [
    {
      "Descrição": "Recebimento de Cliente",
      "Valor": "R\$ 5000.00",
      "Data": "15/12/2024"
    },
    {
      "Descrição": "Pagamento de Fornecedor",
      "Valor": "-R\$ 1200.00",
      "Data": "14/12/2024"
    },
    {
      "Descrição": "Compra de Material",
      "Valor": "-R\$ 300.00",
      "Data": "13/12/2024"
    },
    {"Descrição": "Receita Extra", "Valor": "R\$ 800.00", "Data": "12/12/2024"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Financeiro'),
        backgroundColor: const Color(0xFF0066CC),
        centerTitle: true,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: Drawer(child: SiderBarComponents()),
      backgroundColor: const Color(0xFFF3F7FB), // Fundo suave
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCard(
            'Saldo Atual', 'R\$ ${saldoAtual.toStringAsFixed(2)}', Colors.teal),
        _buildCard('Receitas', 'R\$ ${totalReceitas.toStringAsFixed(2)}',
            Colors.green),
        _buildCard('Despesas', 'R\$ ${totalDespesas.toStringAsFixed(2)}',
            Colors.redAccent),
      ],
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
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  transacao["Descrição"]!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Data: ${transacao["Data"]}'),
                trailing: Text(
                  transacao["Valor"]!,
                  style: TextStyle(
                    color: transacao["Valor"]!.contains('-')
                        ? Colors.red
                        : Colors.green,
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
