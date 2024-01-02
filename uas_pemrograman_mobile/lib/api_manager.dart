import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class ApiManager {
  final String baseUrl;
  final storage = FlutterSecureStorage();

  ApiManager({required this.baseUrl});

  Future<void> addKost(
  String name,
  String type,
  String photo,
  String location,
  String price,
  String facilities,
) async {
  
    final response = await http.post(
      Uri.parse('$baseUrl/kosts'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'name': name,
        'type': type,
        'photo': photo,
        'location': location,
        'price': price,
        'facilities': facilities,
      },
    );

    print(response);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to add kost');
    }
  
}


  Future<void> addKostt(
    String name,
    String type,
    String photo,
    String location,
    String price,
    String facilities,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_kost.php'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'name': name,
        'type': type,
        'photo': photo,
        'location': location,
        'price': price,
        'facilities': facilities,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add kost');
    }
  }

  Future<List<Map<String, dynamic>>> getKosts() async {
    final response = await http.get(Uri.parse('$baseUrl/kost'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse);
    } else {
      throw Exception('Failed to get kosts');
    }
  }

  Future<void> updateKost({
    required int id,
    required String name,
    required String type,
    required String photo,
    required String location,
    required double price,
    required List<String> facilities,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/kosts/{id}'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'id': id.toString(),
        'name': name,
        'type': type,
        'photo': photo,
        'location': location,
        'price': price.toString(),
        'facilities': facilities,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update kost');
    }
  }

  Future<void> deleteKost(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/kosts/{id}'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete kost');
    }
  }

  Future<String?> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'name': name,
        'email': email,
        'password': password
      },
    );

    if (response.statusCode == 201) {
      final token = "Succesfully";
      return token;
    } else {
      throw Exception('Failed to registertgtbtbtbttbtbtbt');

    }
  }


  Future<void> login2(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'email': email,
        'password': password,
      },
    );

    
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];

      await storage.write(key: 'auth_token', value: token);

      return token;
    
    
  }

  Future<String?> login(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];

      await storage.write(key: 'auth_token', value: token);

      return token;
    } else {
      throw Exception('Failed to login');
    }
  } catch (e) {
    print('Error in login: $e');
    throw e;
  }
}


  Future<String?> authenticate(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];

      // Save the token securely
      await storage.write(key: 'kode_rahassia', value: token);

      return token;
    } else {
      throw Exception('Failed to authenticate');
    }
  }
}
