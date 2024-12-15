import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../components/siderbar_components.dart';
import 'package:klitzke_orcamento/models/dashboard_data.dart';
import 'package:klitzke_orcamento/services/api_service.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<DashboardData> dashboardData;
  late Future<DashboardDataProduct> dashboardDataProduct;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Klitzke Dashboard'),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: Drawer(child: SiderBarComponents()),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bem-vindo à Dashboard!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<DashboardDataProduct>(
                future: dashboardDataProduct,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao carregar dados.'));
                  }

                  final dataproduct = snapshot.data!;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCard(
                          'Produtos',
                          dataproduct.productCount.toString(),
                          Colors.blueAccent),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              FutureBuilder<DashboardData>(
                future: dashboardData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || snapshot.data == null) {
                    return const Center(child: Text('Erro ao carregar dados.'));
                  }

                  final data = snapshot.data!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vendas Recentes',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      const SizedBox(height: 20),
                      CarouselSlider.builder(
                        itemCount: data.sales.length,
                        itemBuilder: (context, index, realIndex) {
                          final sale = data.sales[index];
                          return Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              title: Text(
                                'Código: ${sale.codigo} - ${sale.clientes}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Data: ${sale.dataVenda} | Total: R\$ ${sale.totalVenda} | Forma: ${sale.formaDePagamento}',
                              ),
                              trailing: Text('Usuário: ${sale.usuarios}'),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 250,
                          viewportFraction: 0.8,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          autoPlay: false,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String count, Color color) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              count,
              style: TextStyle(
                color: color,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
