
import 'package:consumo_api/app/data/models/produto_model.dart';
import 'package:flutter/material.dart';

import '../../../data/http/exceptions.dart';
import '../../../data/models/repositories/produto_repository.dart';

class ProdutoStore {
  final IProdutoReposity repository;
  // Variável reativa para loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variável reativa para state
  final ValueNotifier<List<ProdutoModel>> state =
      ValueNotifier<List<ProdutoModel>>([]);

  // Variável reativa para erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProdutoStore({required this.repository});

  Future getProdutos() async {
    isLoading.value = true;

    try {
      final result = await repository.getProdutos();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
