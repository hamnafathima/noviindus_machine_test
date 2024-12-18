import 'package:flutter/material.dart';
import 'package:flutter_machine_test/constants/api_urls.dart';
import 'package:flutter_machine_test/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPatientProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> registerPatient({
    required String name,
    required String executive,
    required String payment,
    required String phone,
    required String address,
    required double totalAmount,
    required double discountAmount,
    required double advanceAmount,
    required double balanceAmount,
    required String dateAndTime,
    required String branch,
    required List<String> maleTreatments,
    required List<String> femaleTreatments,
    required List<String> treatments,
  }) async {
    print('--- RegisterPatientProvider: registerPatient called ---');
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      print('Loading state set to true');

     
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print('Token retrieved from SharedPreferences: $token');

      if (token == null) {
        _error = 'No token found. Please login again.';
        _isLoading = false;
        notifyListeners();
        print('Error: No token found in SharedPreferences');
        return false;
      }

      final formData = {
        'name': name,
        'excecutive': executive,
        'payment': payment,
        'phone': phone,
        'address': address,
        'total_amount': totalAmount.toString(),
        'discount_amount': discountAmount.toString(),
        'advance_amount': advanceAmount.toString(),
        'balance_amount': balanceAmount.toString(),
        'date_nd_time': dateAndTime,
        'id':" ",
        'male':"2",
        'female': "2",
        'branch': "branch",
        'treatments': "Head Massage",
      };

      print('Form data prepared: $formData');

      final apiUrl = '${ApiUrls.baseUrl}/${ApiUrls.updatePatient()}';
      print('Sending POST request to: $apiUrl');

      final response = await _apiService.post(apiUrl, formData, token: token);

      print('Response received: $response');

      _isLoading = false;
      notifyListeners();
      print('Loading state set to false');

      if (response['status'] == true) {
        print('Patient registration successful.');
        return true;
      } else {
        _error = response['message'] ?? 'Registration failed';
        print('Error message from response: $_error');
        return false;
      }

    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      print('Exception occurred: $_error');
      return false;
    }
  }
}
