import 'package:klitzke_orcamento/dio/api_client.dart';

class PostServices {
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
}
