import 'package:flutter/material.dart';
import 'package:klitzke_orcamento/data/http/exceptions.dart';
import 'package:klitzke_orcamento/data/models/transacao_model.dart';
import 'package:klitzke_orcamento/data/repositories/transacao_repository.dart';

class TransacaoStore {
  final ITransacaoRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<TransacaoModel>> state =
      ValueNotifier<List<TransacaoModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  TransacaoStore({required this.repository});

  Future getTransacao() async {
    try {
      final result = await repository.getTransacao();
      state.value = result;
      print('result store: $result');
    } catch (error) {
      erro.value = error.toString();
      NotFoundException('Erro ao carregar $erro.value');
    }
  }
}
