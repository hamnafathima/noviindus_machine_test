import 'package:flutter/material.dart';
import 'package:flutter_machine_test/constants/colors.dart';
import 'package:flutter_machine_test/constants/icons.dart';
import 'package:flutter_machine_test/constants/text_styles.dart';
import 'package:flutter_machine_test/constants/ui_styles.dart';
import 'package:flutter_machine_test/patient_details_screen/patient_details_screen.dart';
import 'package:flutter_machine_test/provider/patient_provider.dart';
import 'package:flutter_machine_test/utils/app_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
   
    if (context.mounted) {
      await context.read<PatientProvider>().fetchPatients();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back),
                  const Spacer(),
                  Stack(
                    children: [
                      SvgPicture.asset(IconClass.notificationIcon),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: ColorClass.white.withOpacity(0.90)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for treatments',
                                hintStyle: TextStyleClass.poppins400TextStyle(
                                    12, ColorClass.white),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  UiStyles.customisedSmallButton(
                      'Search', ColorClass.darkGreen, () {})
                ],
              ),
              const SizedBox(height: 35),
              Row(
                children: [
                  Text(
                    'Sort by :',
                    style: TextStyleClass.poppins500TextStyle(
                        12, ColorClass.darkGrey),
                  ),
                  const Spacer(),
                  Container(
                    height: 39,
                    width: 169,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Date',
                              style: TextStyleClass.poppins400TextStyle(
                                  15, ColorClass.darkGrey)),
                          const SizedBox(width: 75),
                          const Icon(Icons.keyboard_arrow_down,
                              color: ColorClass.darkGreen),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 21),
              Divider(
                color: ColorClass.darkGrey.withOpacity(0.2),
                thickness: 2.0,
              ),
              const SizedBox(height: 14),
               Expanded(
                child: Consumer<PatientProvider>(
                  builder: (context, patientProvider, child) {
                    if (patientProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (patientProvider.patients.isEmpty) {
                      return const Center(child: Text('No patients found'));
                    }

                    return ListView.builder(
                      itemCount: patientProvider.patients.length,
                      itemBuilder: (context, index) {
                        final patient = patientProvider.patients[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: ColorClass.lightGrey,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${index + 1}.',
                                      style: TextStyleClass.poppins500TextStyle(
                                          16, ColorClass.darkGrey),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        patient.name ?? 'No Name',
                                        style: TextStyleClass.poppins500TextStyle(
                                            18, ColorClass.black),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                if (patient.patientdetailsSet?.isNotEmpty ?? false)
                                  Text(
                                    patient.patientdetailsSet!.first.treatmentName ?? 'No Treatment',
                                    style: TextStyleClass.poppins300TextStyle(
                                        16, ColorClass.darkGreen),
                                  ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      patient.dateNdTime?.toString().split(' ')[0] ?? 'No Date',
                                      style: TextStyleClass.poppins400TextStyle(
                                          15, ColorClass.darkGrey),
                                    ),
                                    const SizedBox(width: 16),
                                    const Icon(
                                      Icons.group,
                                      size: 16,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      patient.user ?? 'No Staff',
                                      style: TextStyleClass.poppins400TextStyle(
                                          14, ColorClass.darkGrey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Divider(
                                  color: ColorClass.darkGrey.withOpacity(0.2),
                                  thickness: 2.0,
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navigate to details screen
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'View Booking details',
                                        style: TextStyleClass.poppins300TextStyle(
                                            16, ColorClass.black),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: ColorClass.darkGreen,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
             ElevatedButton(
  onPressed: () {
    AppUtils.navigateTo(context, const PatientDetailsScreen());
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: ColorClass.darkGreen,
    minimumSize: const Size(double.infinity, 50), // Makes button width full
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: Text(
    'Register Now',
    style: TextStyleClass.poppins500TextStyle(16, ColorClass.white),
  ),
)
            ],
          ),
        ),
      ),
    );
  }
}
