import 'package:flutter/material.dart';
import 'package:flutter_machine_test/constants/colors.dart';
import 'package:flutter_machine_test/constants/images.dart';
import 'package:flutter_machine_test/constants/text_styles.dart';
import 'package:flutter_machine_test/constants/ui_styles.dart';
import 'package:flutter_machine_test/provider/login_provider.dart';
import 'package:flutter_machine_test/register_screen/register_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, loginProvider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      ImageClass.bg_Frame,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 100,
                      left: MediaQuery.of(context).size.width / 2 - 40,
                      child: Image.asset(ImageClass.logo_Image),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Login Or Register To Book\nYour Appointments',
                        style: TextStyleClass.poppins600TextStyle(
                          24,
                          ColorClass.darkGrey,
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (loginProvider.error != null)
                        Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            loginProvider.error!,
                            style: TextStyle(color: Colors.red.shade700),
                          ),
                        ),
                      Text(
                        'Email',
                        style: TextStyleClass.poppins400TextStyle(
                          16,
                          ColorClass.darkGrey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: loginProvider.username,
                        decoration: InputDecoration(
                          fillColor: ColorClass.white.withOpacity(0.25),
                          filled: true,
                          labelText: 'Enter your email',
                          labelStyle: TextStyleClass.poppins300TextStyle(
                            14,
                            ColorClass.black.withOpacity(0.4),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: ColorClass.black.withOpacity(0.10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'Password',
                        style: TextStyleClass.poppins400TextStyle(
                          16,
                          ColorClass.darkGrey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: loginProvider.password,
                        decoration: InputDecoration(
                          fillColor: ColorClass.white.withOpacity(0.25),
                          filled: true,
                          labelText: 'Enter Password',
                          labelStyle: TextStyleClass.poppins300TextStyle(
                            14,
                            ColorClass.black.withOpacity(0.4),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ColorClass.black.withOpacity(0.10),
                            ),
                          ),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 84),
                   Center(
  child: ElevatedButton(
    onPressed: loginProvider.isLoading
        ? null
        : () async {
            // Validate inputs
            if (loginProvider.username.text.trim().isEmpty ||
                loginProvider.password.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter both username and password'),
                ),
              );
              return;
            }

            try {
              await loginProvider.login(context);
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            }
          },
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorClass.darkGreen,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: Text(
      loginProvider.isLoading ? 'Logging in...' : 'Login',
      style: TextStyleClass.poppins500TextStyle(16, Colors.white),
    ),
  ),
),  
                  const SizedBox(height: 50),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text:
                            'By creating or logging into an account you are agreeing\nwith our ',
                        style: TextStyleClass.poppins300TextStyle(
                            12, ColorClass.black),
                        children: [
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyleClass.poppins500TextStyle(
                                12, ColorClass.darkBlue),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyleClass.poppins300TextStyle(
                                12, ColorClass.black),
                          ),
                          TextSpan(
                            text: 'Privacy Policy.',
                            style: TextStyleClass.poppins500TextStyle(
                                12, ColorClass.darkBlue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }));
  }
  
}
