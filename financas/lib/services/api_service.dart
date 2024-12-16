import 'package:klitzke_orcamento/dio/api_client.dart';

class PostServices {
  Future<bool> registerAccounts(String account, String balance) async {
    try {
      final response = await dio.post('/registerAccounts',
          data: {'account': account, 'balance': balance});

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> registerExpense(data) async {
    try {
      final response = await dio.post('registerExpense', data: {'expense': data});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> registerCategory(String category, String type) async {
    try {
      final response = await dio
          .post('registerCategory', data: {'category': category, 'type': type});

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Erro ao fazer autenticação: $error');
      return false;
    }
  }
}

class GetServices {
  Future<List<Map<String, dynamic>>> getCategorys() async {
    try {
      final response = await dio.get('getCategorys');

      if (response.data != null && response.data['getCategorys'] != null) {
        return List<Map<String, dynamic>>.from(response.data['getCategorys']);
      } else {
        return [];
      }
    } catch (error) {
      print('Erro ao buscar lista de categorias $error');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getAccounts() async {
    try {
      final response = await dio.get('getAccounts');

      if (response.data != null && response.data['getAccounts'] != null) {
        return List<Map<String, dynamic>>.from(response.data['getAccounts']);
      } else {
        return [];
      }
    } catch (error) {
      print('Erro ao buscar lista de constas $error');
      return [];
    }
  }
}
