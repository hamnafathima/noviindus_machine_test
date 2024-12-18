import 'package:flutter/material.dart';
import 'package:flutter_machine_test/constants/api_urls.dart';
import 'package:flutter_machine_test/model/treatment_model.dart';
import 'package:flutter_machine_test/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TreatmentProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  TreatmentModel? _treatmentModel;
  bool _isLoading = false;
  String? _error;

  List<Treatment> get treatments => _treatmentModel?.treatments ?? [];
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasData => _treatmentModel != null && treatments.isNotEmpty;

  Future<void> fetchTreatments() async {
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
          await _apiService.get(ApiUrls.getTreatmentList(), token: token);
      _treatmentModel = TreatmentModel.fromJson(response);

      if (!_treatmentModel!.status!) {
        _error = _treatmentModel?.message ?? 'Failed to fetch treatments';
      }
    } catch (e) {
      _error = e.toString();
      debugPrint("Treatment List Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    _treatmentModel = null;
    notifyListeners();
    await fetchTreatments();
  }

  void clear() {
    _treatmentModel = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  Treatment? getTreatmentById(String id) {
    try {
      return treatments
          .firstWhere((treatment) => treatment.id.toString() == id);
    } catch (e) {
      return null;
    }
  }

  String getPriceById(String id) {
    return getTreatmentById(id)?.price ?? '0';
  }

  List<Treatment> searchTreatments(String query) {
    if (query.isEmpty) return treatments;

    return treatments.where((treatment) {
      final name = treatment.name?.toLowerCase() ?? '';
      final searchLower = query.toLowerCase();

      return name.contains(searchLower);
    }).toList();
  }
}
