class TransacaoModel {
  final double valor;
  final String tipo;
  final String descricao;
  final int conta_id;
  final int categoria_id;

  TransacaoModel(
      {required this.valor,
      required this.tipo,
      required this.descricao,
      required this.conta_id,
      required this.categoria_id});

  factory TransacaoModel.fromMap(Map<String, dynamic> map) {
    return TransacaoModel(
      valor: map['valor'] * 1.0,
      tipo: map['tipo'],
      descricao: map['descricao'],
      conta_id: map['conta_id'],
      categoria_id: map['categoria_id'],
    );
  }
}
