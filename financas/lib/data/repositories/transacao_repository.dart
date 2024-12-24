import 'dart:convert';

import 'package:klitzke_orcamento/data/http/exceptions.dart';
import 'package:klitzke_orcamento/data/http/http_client.dart';
import 'package:klitzke_orcamento/data/models/transacao_model.dart';

abstract class ITransacaoRepository {
  Future<List<TransacaoModel>> getTransacao();
}

class TransacaoRepository implements ITransacaoRepository {
  final IHttpClient client;

  TransacaoRepository({required this.client});

  @override
  Future<List<TransacaoModel>> getTransacao() async {
    final List<TransacaoModel> transacoes = [];

    try {
      final response =
          await client.get(url: 'http://192.168.1.4:3000/api/getTransition');

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['getTransition'] is List) {
          for (var item in body['getTransition']) {
            if (item['valor'] is String) {
              item['valor'] = item['valor'].replaceAll(RegExp(r'\s'), '');
            }
            final TransacaoModel transacao = TransacaoModel.fromMap(item);
            transacoes.add(transacao);
          }
        } else {
          throw NotFoundException('Formato inválido do JSON.');
        }

        print('Transações carregadas: $transacoes');
        return transacoes;
      } else if (response.statusCode == 404) {
        throw NotFoundException('URL inválida!');
      } else {
        throw NotFoundException('Transações não encontradas');
      }
    } on NotFoundException catch (e) {
      print('Erro NotFoundException: ${e.message}');
      return [];
    } catch (error) {
      print('Erro inesperado: $error');
      return [];
    }
  }
}
