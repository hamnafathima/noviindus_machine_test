import 'package:flutter/material.dart';
import 'package:flutter_machine_test/constants/colors.dart';
import 'package:flutter_machine_test/constants/icons.dart';
import 'package:flutter_machine_test/constants/text_styles.dart';
import 'package:flutter_machine_test/constants/ui_styles.dart';
import 'package:flutter_machine_test/model/branch_model.dart';
import 'package:flutter_machine_test/model/treatment_model.dart';
import 'package:flutter_machine_test/provider/branch_list_provider.dart';
import 'package:flutter_machine_test/provider/register_patient_provider.dart';
import 'package:flutter_machine_test/provider/treatment_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  String? _paymentMethod = 'Cash';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _treatmentController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _discountAmountController =
      TextEditingController();
  final TextEditingController _advanceAmountController =
      TextEditingController();
  final TextEditingController _balanceAmountController =
      TextEditingController();
  final TextEditingController _treatmentDateController =
      TextEditingController();
  final TextEditingController _treatmentTimeController =
      TextEditingController();
  final TextEditingController _treatmentChooseController =
      TextEditingController();
  List<String> maleTreatments = [];
  List<String> femaleTreatments = [];
  List<String> selectedTreatments = [];
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final dateTime =
          '${_treatmentDateController.text}-${_treatmentTimeController.text}';

      final success = await context
          .read<RegisterPatientProvider>()
          .registerPatient(
            name: _nameController.text,
            executive: 'test_user',
            payment: _paymentMethod ?? 'Cash',
            phone: _whatsappController.text,
            address: _addressController.text,
            totalAmount: double.tryParse(_totalAmountController.text) ?? 0,
            discountAmount:
                double.tryParse(_discountAmountController.text) ?? 0,
            advanceAmount: double.tryParse(_advanceAmountController.text) ?? 0,
            balanceAmount: double.tryParse(_balanceAmountController.text) ?? 0,
            dateAndTime: dateTime,
            branch: _branchController.text,
            maleTreatments: maleTreatments,
            femaleTreatments: femaleTreatments,
            treatments: selectedTreatments,
          );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Patient registered successfully')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BranchProvider>().fetchBranches();
      context.read<TreatmentProvider>().fetchTreatments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 23),
                Text(
                  'Register',
                  style: TextStyleClass.poppins600TextStyle(
                      24, ColorClass.darkGrey),
                ),
                const SizedBox(height: 12),
                Divider(
                  color: ColorClass.darkGrey.withOpacity(0.2),
                  thickness: 2.0,
                ),
                const SizedBox(height: 12),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      _buildTextField(
                          _nameController, 'Enter your full name', 'Name'),
                      Text(
                        'Whatsapp Number',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      _buildTextField(_whatsappController,
                          'Enter your Whatsapp Number', 'Whatsapp number'),
                      Text(
                        'Address',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      _buildTextField(_addressController,
                          'Enter your full Address', 'Address'),
                      Text(
                        'Location',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      _buildDropdownField(_locationController,
                          'Choose your Location', 'Location'),
                      Text(
                        'Branch',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      _buildDropdownField(
                          _branchController, 'Select the Branch', 'Branch'),
                      Text(
                        'Total Amount',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      _buildTextField(_totalAmountController, '', ''),
                      Text(
                        'Discount Amount',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      _buildTextField(_discountAmountController, '', ''),
                      Text(
                        'Payment Option',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Radio<String>(
                                  value: 'Cash',
                                  groupValue: _paymentMethod,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _paymentMethod = value;
                                    });
                                  },
                                ),
                                const Text('Cash'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Radio<String>(
                                  value: 'Card',
                                  groupValue: _paymentMethod,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _paymentMethod = value;
                                    });
                                  },
                                ),
                                const Text('Card'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Radio<String>(
                                  value: 'UPI',
                                  groupValue: _paymentMethod,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _paymentMethod = value;
                                    });
                                  },
                                ),
                                const Text('UPI'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Advance Amount',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      _buildTextField(_advanceAmountController, '', ''),
                      Text(
                        'Balance Amount',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      _buildTextField(_balanceAmountController, '', ''),
                      Text(
                        'Treatment Date',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      _buildDatePickerField(_treatmentDateController, ''),
                      Text(
                        'Treatment Time',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      _buildTimePickerField(_treatmentTimeController, ''),
                      Text(
                        'Choose Treatment',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      _buildTreatmentsSection(),
                      Text(
                        'Add Patients',
                        style: TextStyleClass.poppins400TextStyle(
                            16, ColorClass.darkGrey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 124,
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorClass.grey),
                                color: ColorClass.black.withOpacity(0.25),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Male',
                                style: TextStyleClass.poppins300TextStyle(
                                    14, ColorClass.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 70,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                                color: ColorClass.darkGreen,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(29))),
                            child: const Center(
                                child: Text(
                              '-',
                              style: TextStyle(
                                  color: ColorClass.white, fontSize: 35),
                            )),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            height: 44,
                            width: 48,
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorClass.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                                color: ColorClass.darkGreen,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(29))),
                            child: const Center(
                                child: Text(
                              '+',
                              style: TextStyle(
                                  color: ColorClass.white, fontSize: 35),
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 124,
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorClass.grey),
                                color: ColorClass.black.withOpacity(0.25),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Female',
                                style: TextStyleClass.poppins300TextStyle(
                                    14, ColorClass.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 70,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                                color: ColorClass.darkGreen,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(29))),
                            child: const Center(
                                child: Text(
                              '-',
                              style: TextStyle(
                                  color: ColorClass.white, fontSize: 35),
                            )),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            height: 44,
                            width: 48,
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorClass.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                                color: ColorClass.darkGreen,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(29))),
                            child: const Center(
                                child: Text(
                              '+',
                              style: TextStyle(
                                  color: ColorClass.white, fontSize: 35),
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed:
                            context.watch<RegisterPatientProvider>().isLoading
                                ? null
                                : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorClass.darkGreen,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          context.watch<RegisterPatientProvider>().isLoading
                              ? 'Saving...'
                              : 'Save',
                          style: TextStyleClass.poppins500TextStyle(
                              16, ColorClass.white),
                        ),
                      ),
                      if (context.watch<RegisterPatientProvider>().error !=
                          null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            context.watch<RegisterPatientProvider>().error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: ColorClass.white.withOpacity(0.25),
          filled: true,
          labelText: label,
          hintStyle: TextStyleClass.poppins300TextStyle(14, ColorClass.grey),
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorClass.black.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(
    TextEditingController controller,
    String label,
    String hint,
  ) {
    return Consumer<BranchProvider>(
      builder: (context, branchProvider, child) {
        if (branchProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            fillColor: ColorClass.white.withOpacity(0.25),
            filled: true,
            labelText: label,
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          value: controller.text.isNotEmpty ? controller.text : null,
          items: branchProvider.branches.map((Branch branch) {
            return DropdownMenuItem<String>(
              value: branch.id.toString(),
              child: Text(branch.name ?? ''),
            );
          }).toList(),
          onChanged: (newValue) {
            controller.text = newValue!;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select $label';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildTreatmentsSection() {
    return Consumer<TreatmentProvider>(
      builder: (context, treatmentProvider, child) {
        if (treatmentProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            fillColor: ColorClass.white.withOpacity(0.25),
            filled: true,
            labelText: "treatment",
            hintText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          value: _treatmentController.text.isNotEmpty
              ? _treatmentController.text
              : null,
          items: treatmentProvider.treatments.map((Treatment treatment) {
            return DropdownMenuItem<String>(
              value: treatment.id.toString(),
              child: Text('${treatment.name ?? ''} - ${treatment.price ?? ''}'),
            );
          }).toList(),
          onChanged: (newValue) {
            _treatmentController.text = newValue!;
            // Update total amount when treatment is selected
            final treatment = treatmentProvider.treatments
                .firstWhere((t) => t.id.toString() == newValue);
            _totalAmountController.text = treatment.price ?? '0';
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select treatment';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildDatePickerField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          fillColor: ColorClass.white.withOpacity(0.25),
          filled: true,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            controller.text = "${pickedDate.toLocal()}".split(' ')[0];
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTimePickerField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          fillColor: ColorClass.white.withOpacity(0.25),
          filled: true,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          suffixIcon: const Icon(Icons.access_time),
        ),
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            controller.text = pickedTime.format(context);
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }
}
