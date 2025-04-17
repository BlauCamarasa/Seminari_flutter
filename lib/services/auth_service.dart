import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  static String get _baseUrl {
    if (kIsWeb) {
      return 'http://localhost:9000/api/users';
    } 
    else if (!kIsWeb && Platform.isAndroid) {
      return 'http://10.0.2.2:9000/api/users';
    } 
    else {
      return 'http://localhost:9000/api/users';
    }
  }

//login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/login');

    final body = json.encode({
      'email': email,
      'password': password,
    });

    try {
      print("enviant solicitud post a: $url");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print("Resposta rebuda amb codi: ${response.statusCode}");

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'error': 'email o contrasenya incorrectes'};
      }
    } catch (e) {
      print("Error al fer la solicitud: $e");
      return {'error':  'Error de connexió'};
    }
  }
}
