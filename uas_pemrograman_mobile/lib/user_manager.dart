import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserManager extends ChangeNotifier {
  final storage = FlutterSecureStorage();
  String? authToken;

  Future<void> setAuthToken(String? token) async {
    authToken = token;
    if (token == null) {
      // Hapus token dari penyimpanan lokal saat logout
      await storage.delete(key: 'kode_rahassia');
    } else {
      // Simpan atau perbarui token ke penyimpanan lokal saat login
      await storage.write(key: 'kode_rahassia', value: token);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    // Hapus token dari penyimpanan lokal saat logout
    await storage.delete(key: 'kode_rahassia');
    authToken = null;
    notifyListeners();
  }

  bool get isAuthenticated => authToken != null;
}