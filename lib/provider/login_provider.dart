import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_machine_test/constants/api_urls.dart';
import 'package:flutter_machine_test/register_screen/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController username =
      TextEditingController(text: "test_user");
  final TextEditingController password =
      TextEditingController(text: "12345678");
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> login(BuildContext context) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      var url = Uri.parse(ApiUrls.loginApi());
      debugPrint('Request URL: ${url.toString()}');

      var request = http.MultipartRequest('POST', url);

      request.fields['username'] = username.text.trim();
      request.fields['password'] = password.text.trim();

      debugPrint('Request Fields: ${request.fields}');

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Headers: ${response.headers}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        debugPrint('Parsed Response Data: $jsonData');

        final prefs = await SharedPreferences.getInstance();
        final token = jsonData['token'];
        debugPrint('Saving Token: $token');
        await prefs.setString('token', token);

        _isLoading = false;
        notifyListeners();

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RegisterScreen()),
          );
        }
        return true;
      } else {
        debugPrint('Login Failed with Status Code: ${response.statusCode}');
        _error = 'Login failed: Invalid credentials';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint('Login error: $e');
      debugPrint('Stack trace: $stackTrace');
      _error = 'Network error. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
}
