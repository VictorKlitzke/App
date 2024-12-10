import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String apiUrl = 'http://localhost:3000/api/login';

  Future<bool> login(String username, String password) async {
    final body = jsonEncode({'username': username, 'password': password});

    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Erro: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Erro ao fazer login: $error');
      return false;
    }
  }
}
