import 'package:dio/dio.dart';
import 'package:klitzke_orcamento/models/dashboard_data.dart';
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
