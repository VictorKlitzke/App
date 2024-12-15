class DashboardData {
  final int salesCount;
  final List<Sale> sales;

  DashboardData({
    required this.salesCount, 
    required this.sales});

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      salesCount: (json['sales'] != null) ? json['sales'].length : 0,
      sales: (json['sales'] != null)
          ? (json['sales'] as List<dynamic>)
              .map((sale) => Sale.fromJson(sale))
              .toList()
          : [], // Retorna uma lista vazia se 'sales' for null
    );
  }
}

class DashboardDataProduct {
  final int productCount;

  DashboardDataProduct({required this.productCount});
  
  factory DashboardDataProduct.fromJson(Map<String, dynamic> json) {
    return DashboardDataProduct(
      productCount: (json["product"] != null) ? json["product"].length : 0,
    );
  }
}

class Sale {
  final int codigo;
  final DateTime dataVenda;
  final double totalVenda;
  final String formaDePagamento;
  final String clientes;
  final String usuarios;

  Sale({
    required this.codigo,
    required this.dataVenda,
    required this.totalVenda,
    required this.formaDePagamento,
    required this.clientes,
    required this.usuarios,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      codigo: json['codigo'] ?? 0,
      dataVenda: json['dataVenda'] != null
          ? DateTime.parse(json['dataVenda'])
          : DateTime.now(), // Trata valores nulos para data
      totalVenda: json['totalVenda'] != null
          ? json['totalVenda'].toDouble()
          : 0.0, // Trata valores nulos para totalVenda
      formaDePagamento: json['formaDePagamento'] ?? 'N/A',
      clientes: json['clientes'] ?? 'N/A',
      usuarios: json['usuarios'] ?? 'N/A',
    );
  }
}
