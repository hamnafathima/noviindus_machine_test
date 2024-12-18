class ApiUrls {
  ///Base Url
  static String baseUrl = 'https://flutter-amr.noviindus.in/api';


  
  static String loginApi() {
    return '$baseUrl/Login';
  }
  static String getPatientList() {
    return 'PatientList';
  }
  static String getBranchList() {
    return 'BranchList';
  }
  static String getTreatmentList() {
    return 'TreatmentList';
  }
  static String updatePatient() {
    return 'PatientUpdate';
  }

}
