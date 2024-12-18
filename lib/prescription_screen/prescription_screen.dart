import 'package:flutter/material.dart';
import 'package:flutter_machine_test/constants/colors.dart';
import 'package:flutter_machine_test/constants/images.dart';
import 'package:flutter_machine_test/constants/text_styles.dart';
import 'package:flutter_machine_test/widgets/dashed_lines.dart';
import 'package:flutter_machine_test/widgets/small_dashed_lines.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Opacity(
                  opacity: 0.1, child: Image.asset(ImageClass.large_Logo)),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(ImageClass.sheet_Logo),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'KUMARAKOM',
                              style: TextStyleClass.poppins600TextStyle(
                                  10, ColorClass.black),
                            ),
                            Text(
                              'Cheepunkal P.O. Kumarakom, kottayam, Kerala - 686563',
                              style: TextStyleClass.poppins600TextStyle(
                                  10, ColorClass.grey),
                            ),
                            Text(
                              'e-mail: unknown@gmail.com',
                              style: TextStyleClass.poppins600TextStyle(
                                  10, ColorClass.grey),
                            ),
                            Text(
                              'Mob: +91 9876543210 | +91 9786543210',
                              style: TextStyleClass.poppins600TextStyle(
                                  10, ColorClass.grey),
                            ),
                            Text(
                              'GST No: 32AABCU9603R1ZW',
                              style: TextStyleClass.poppins600TextStyle(
                                  10, ColorClass.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Divider(
                      color: ColorClass.darkGrey.withOpacity(0.2),
                      thickness: 2.0,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      'Patient Details',
                      style: TextStyleClass.poppins600TextStyle(
                          13, ColorClass.green),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          'Name',
                          style: TextStyleClass.poppins600TextStyle(
                              10, ColorClass.black),
                        ),
                        const SizedBox(
                          width: 78,
                        ),
                        Text(
                          'Salih T',
                          style: TextStyleClass.poppins600TextStyle(
                              10, ColorClass.grey),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          'Booked On',
                          style: TextStyleClass.poppins600TextStyle(
                              10, ColorClass.black),
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        Text(
                          '31/01/2024   |   12:12pm',
                          style: TextStyleClass.poppins600TextStyle(
                              10, ColorClass.grey),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Address',
                          style: TextStyleClass.poppins600TextStyle(
                              10, ColorClass.black),
                        ),
                        const SizedBox(
                          width: 68,
                        ),
                        Text(
                          'Nadakkave',
                          style: TextStyleClass.poppins600TextStyle(
                              10, ColorClass.grey),
                        ),
                        const SizedBox(
                          width: 27,
                        ),
                        Text(
                          'Treatment Date',
                          style: TextStyleClass.poppins600TextStyle(
                              10, ColorClass.black),
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        Text(
                          '21/02/2024',
                          style: TextStyleClass.poppins600TextStyle(
                              10, ColorClass.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Whatsapp Number',
                          style: TextStyleClass.poppins600TextStyle(
                              10, ColorClass.black),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '+91 987654321',
                          style: TextStyleClass.poppins600TextStyle(
                              10, ColorClass.grey),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Treatment Time',
                          style: TextStyleClass.poppins600TextStyle(
                              10, ColorClass.black),
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        Text(
                          '11:00 am',
                          style: TextStyleClass.poppins600TextStyle(
                              10, ColorClass.grey),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const DottedLine(),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'Treatment',
                          style: TextStyleClass.poppins600TextStyle(
                              13, ColorClass.green),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          'Price',
                          style: TextStyleClass.poppins600TextStyle(
                              13, ColorClass.green),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Male',
                          style: TextStyleClass.poppins600TextStyle(
                              13, ColorClass.green),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Female',
                          style: TextStyleClass.poppins600TextStyle(
                              13, ColorClass.green),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Total',
                          style: TextStyleClass.poppins600TextStyle(
                              13, ColorClass.green),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    Row(
                      children: [
                        Text(
                          'Panchakarma',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          '230',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          '4',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          '4',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                        const SizedBox(
                          width: 70,
                        ),
                        Text(
                          '2540',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          'Njavara Kizhi\nTreatment',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        Text(
                          '230',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          '4',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          '4',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                        const SizedBox(
                          width: 70,
                        ),
                        Text(
                          '2540',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          'Panchakarma',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          '230',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          '4',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          '4',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                        const SizedBox(
                          width: 70,
                        ),
                        Text(
                          '2540',
                          style: TextStyleClass.poppins500TextStyle(
                              13, ColorClass.deepGrey),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const DottedLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total Amount',
                          style: TextStyleClass.poppins600TextStyle(
                              13, ColorClass.black),
                        ),
                        const SizedBox(
                          width: 38,
                        ),
                        Text(
                          '7620',
                          style: TextStyleClass.poppins600TextStyle(
                              13, ColorClass.black),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Discount',
                          style: TextStyleClass.poppins400TextStyle(
                              13, ColorClass.black),
                        ),
                        const SizedBox(
                          width: 73,
                        ),
                        Text(
                          '500',
                          style: TextStyleClass.poppins400TextStyle(
                              13, ColorClass.black),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Advance',
                          style: TextStyleClass.poppins400TextStyle(
                              13, ColorClass.black),
                        ),
                        const SizedBox(
                          width: 67,
                        ),
                        Text(
                          '1200',
                          style: TextStyleClass.poppins400TextStyle(
                              13, ColorClass.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Align(
                        alignment: Alignment.centerRight,
                        child: DottedSmallLine()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Balance',
                          style: TextStyleClass.poppins600TextStyle(
                              13, ColorClass.black),
                        ),
                        const SizedBox(
                          width: 68,
                        ),
                        Text(
                          '5920',
                          style: TextStyleClass.poppins600TextStyle(
                              13, ColorClass.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Thank you for choosing us',
                        style: TextStyleClass.poppins500TextStyle(
                            16, ColorClass.green),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Your well-being is our commitment, and we\'re honored',
                        style: TextStyleClass.poppins400TextStyle(
                            10, ColorClass.grey),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'you\'ve entrusted us with your health journey',
                        style: TextStyleClass.poppins400TextStyle(
                            10, ColorClass.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(ImageClass.sign_Img)),
                    const SizedBox(
                      height: 25,
                    ),
                    const DottedLine(),
                    Center(
                      child: Text(
                        '"Booking amount is non-refundable, and it\'s important to arrive on the allotted time for your treatmen"',
                        style: TextStyleClass.poppins400TextStyle(
                            7, ColorClass.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
