import 'package:flutter/material.dart';
import 'package:flutter_machine_test/constants/api_urls.dart';
import 'package:flutter_machine_test/model/branch_model.dart';
import 'package:flutter_machine_test/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BranchProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  BranchModel? _branchModel;
  bool _isLoading = false;
  String? _error;

  List<Branch> get branches => _branchModel?.branches ?? [];
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchBranches() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await _apiService.get(ApiUrls.getBranchList(), token: token);
      _branchModel = BranchModel.fromJson(response);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      debugPrint("Branch List Error: $e");
      notifyListeners();
    }
  }
}
