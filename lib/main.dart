import 'package:flutter/material.dart';
import 'package:flutter_machine_test/patient_details_screen/patient_details_screen.dart';
import 'package:flutter_machine_test/prescription_screen/prescription_screen.dart';
import 'package:flutter_machine_test/provider/branch_list_provider.dart';
import 'package:flutter_machine_test/provider/login_provider.dart';
import 'package:flutter_machine_test/provider/patient_provider.dart';
import 'package:flutter_machine_test/provider/register_patient_provider.dart';
import 'package:flutter_machine_test/provider/treatment_provider.dart';
import 'package:flutter_machine_test/register_screen/register_screen.dart';
import 'package:flutter_machine_test/splash_screen/splash_screen.dart';
import 'package:flutter_machine_test/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
          ChangeNotifierProvider<PatientProvider>(
              create: (_) => PatientProvider()),
         
          ChangeNotifierProvider<TreatmentProvider>(
              create: (_) => TreatmentProvider()),
          ChangeNotifierProvider(create: (_) => RegisterPatientProvider()),
          ChangeNotifierProvider(create: (_) => BranchProvider()),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ));
  }
}
