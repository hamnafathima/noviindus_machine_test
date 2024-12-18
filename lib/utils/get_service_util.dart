import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_machine_test/utils/shared_utils.dart';
import 'package:flutter_machine_test/utils/string_class.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'app_utils.dart';

class GetServiceUtils {
  static Future<String> fetchData(String getUrl, BuildContext context) async {
    try {
      final hasNetwork = await AppUtils.hasInternet();
      if (!hasNetwork) {
        if (context.mounted) {
          AppUtils.showInSnackBarNormal('No internet connection', context);
        }
        throw Exception('No internet connection');
      } else {
        debugPrint('Has Internet');
        final url = Uri.parse(getUrl);
        String token = await SharedUtils.getString(StringClass.token);
        debugPrint(token.toString());
        final headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        };
        final response = await http.get(url, headers: headers);
        if (response.statusCode == 200) {
          if (kDebugMode) {
            log('$url: ${response.body}');
          }
          return response.body;
        } else if (response.statusCode == 500) {
          if (context.mounted) {
            AppUtils.showInSnackBarNormal(
                'status code: ${response.statusCode}, - Bad Gateway', context);
          }
          debugPrint('$url status code: ${response.statusCode}');
          throw Exception('Failed to get Data');
        } else if (response.statusCode == 401) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          // if (context.mounted) {
          //   Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //           builder: (BuildContext context) =>
          //               const SplashScreen()));
          //   AppUtils.showInSnackBarNormal(
          //       '${response.statusCode}, - Login Failed', context);
          // }
          debugPrint('$url status code: ${response.statusCode}');
          throw Exception('Failed to get Data');
        } else {
          if (context.mounted) {
            AppUtils.showInSnackBarNormal(
                'status code: ${response.statusCode}, Failed to get Data',
                context);
          }
          debugPrint('$url status code: ${response.statusCode}');
          throw Exception('Failed to get Data');
        }
      }
    } catch (e) {
      // Show the exception message in a snack bar
      // Rethrow the exception so the calling code can handle it if necessary
      rethrow;
    }
  }

  static Future<String> postData(
      String postUrl, Map<String, dynamic> body, BuildContext context) async {
    try {
      final hasNetwork = await AppUtils.hasInternet();
      if (!hasNetwork) {
        if (context.mounted) {
          AppUtils.showInSnackBarNormal('No internet connection', context);
        }
        throw Exception('No internet connection');
      } else {
        final url = Uri.parse(postUrl);
        String token = await SharedUtils.getString('TOKEN');
        final headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        };
        final response =
            await http.post(url, headers: headers, body: json.encode(body));
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (kDebugMode) {
            log('$url: ${response.body}');
          }
          AppUtils.showInSnackBarNormal("New Member Added", context);
          return response.body;
        } else {
          // Error handling for other status codes
          if (context.mounted) {
            AppUtils.showInSnackBarNormal(
                'Error ${response.statusCode}: ${response.reasonPhrase}',
                context);
          }
          debugPrint(
              '$url status code: ${response.statusCode}, ${response.reasonPhrase}');
          throw Exception('Failed to post data');
        }
      }
    } catch (e) {
      if (context.mounted) {
        AppUtils.showInSnackBarNormal('Error: ${e.toString()}', context);
      }
      rethrow;
    }
  }

  static Future<String> putData(
      String putUrl, Map<String, dynamic> body, BuildContext context) async {
    try {
      final hasNetwork = await AppUtils.hasInternet();
      if (!hasNetwork) {
        if (context.mounted) {
          AppUtils.showInSnackBarNormal('No internet connection', context);
        }
        throw Exception('No internet connection');
      } else {
        final url = Uri.parse(putUrl);
        String token = await SharedUtils.getString('TOKEN');
        final headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        };
        final response =
            await http.put(url, headers: headers, body: json.encode(body));
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Success
          if (kDebugMode) {
            log('$url: ${response.body}');
          }
          AppUtils.showInSnackBarNormal("Member Updated Successfully", context);

          return response.body;
        } else {
          // Error handling for other status codes
          if (context.mounted) {
            AppUtils.showInSnackBarNormal(
                'Error ${response.statusCode}: ${response.reasonPhrase}',
                context);
          }
          debugPrint(
              '$url status code: ${response.statusCode}, ${response.reasonPhrase}');
          throw Exception('Failed to update data');
        }
      }
    } catch (e) {
      if (context.mounted) {
        AppUtils.showInSnackBarNormal('Error: ${e.toString()}', context);
      }
      rethrow;
    }
  }
}
