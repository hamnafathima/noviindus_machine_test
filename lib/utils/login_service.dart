
import 'package:flutter/material.dart';
import 'package:flutter_machine_test/constants/api_urls.dart';
import 'package:http/http.dart' as http;


import '../../utils/app_utils.dart';



class LoginService {

  

  static Future<String> login(String username, String password) async {
    final hasNetwork = await AppUtils.hasInternet();
    if (hasNetwork) {
      try {
        final url = Uri.parse(ApiUrls.loginApi());
        debugPrint('login url: ${ApiUrls.loginApi()}');
        final body = {
          "username": username,
          "password": password
        };
        debugPrint('login url: ${body}');
        final response = await http.post(url, body: body);
        if (response.statusCode == 200) {
          // loginModel = loginModelFromJson(response.body);
          return response.body.toString();
        } else if (response.statusCode == 401) {
          return '';
        }
      } catch (e) {
        return e.toString();
      }
    } else {
      return 'No internet connection';
    }
    return '';
  }
}


