import 'package:flutter/material.dart';
import 'package:flutter_machine_test/constants/api_urls.dart';
import 'package:flutter_machine_test/model/patient_model.dart';
import 'package:flutter_machine_test/service/api_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PatientProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  PatientModel? _patientModel;
  bool _isLoading = false;
  String? _error;

  List<Patient> get patients => _patientModel?.patient ?? [];
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasData => _patientModel != null && patients.isNotEmpty;

  Future<void> fetchPatients() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        _error = 'No token found. Please login again.';
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response =
          await _apiService.get(ApiUrls.getPatientList(), token: token);
      _patientModel = PatientModel.fromJson(response);

      if (!_patientModel!.status!) {
        _error = _patientModel?.message ?? 'Failed to fetch patients';
      }
    } catch (e) {
      _error = e.toString();
      debugPrint("Patient List Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    _patientModel = null;
    notifyListeners();
    await fetchPatients();
  }

  void clear() {
    _patientModel = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  List<Patient> searchPatients(String query) {
    if (query.isEmpty) return patients;

    return patients.where((patient) {
      final name = patient.name?.toLowerCase() ?? '';
      final phone = patient.phone?.toLowerCase() ?? '';
      final searchLower = query.toLowerCase();

      return name.contains(searchLower) || phone.contains(searchLower);
    }).toList();
  }
}
