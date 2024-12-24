import 'package:flutter/material.dart';
import 'package:klitzke_orcamento/data/models/transacao_model.dart';
import 'package:klitzke_orcamento/pages/stores/transacao_sore.dart';
// import 'package:klitzke_orcamento/store/transacao_store.dart';

class ListTransacao extends StatefulWidget {
  final TransacaoStore store;

  const ListTransacao({Key? key, required this.store}) : super(key: key);

  @override
  _ListTransacao createState() => _ListTransacao();
}

class _ListTransacao extends State<ListTransacao> {
  @override
  void initState() {
    super.initState();
    widget.store.getTransacao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<List<TransacaoModel>>(
        valueListenable: widget.store.state,
        builder: (context, transacoes, _) {
          print('testeste: $transacoes');
          if (widget.store.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (transacoes.isEmpty) {
            return const Center(child: Text('Nenhuma transação encontrada'));
          }

          return ListView.builder(
            itemCount: transacoes.length,
            itemBuilder: (context, index) {
              final transacao = transacoes[index];
              return Card(
                child: ListTile(
                  leading: Icon(
                    transacao.tipo == 'Entrada'
                        ? Icons.arrow_circle_up
                        : Icons.arrow_circle_down,
                    color:
                        transacao.tipo == 'Entrada' ? Colors.green : Colors.red,
                  ),
                  title: Text(transacao.descricao),
                  subtitle: Text(
                      'Valor: R\$ ${transacao.valor.toStringAsFixed(2)} | Conta: ${transacao.conta_id} | Categoria: ${transacao.categoria_id}'),
                  trailing: Text(
                    transacao.tipo,
                    style: TextStyle(
                      color: transacao.tipo == 'Entrada'
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
