// Masjid admin user login screen. This screen is used to login to the admin
// panel. The screen includes email and password input fields and a login button.
// Upon successful login, the user is redirected to the admin panel screen.

// Stdlib
import 'package:flutter/material.dart';

// 3rd party
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Local
import 'package:inha_masjid/utils/colors.dart';
import 'package:inha_masjid/utils/dimensions.dart';
import 'package:inha_masjid/utils/strings.dart';

/// Login screen widget for Masjid admin users.
class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({super.key});

  // Variables
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Functions
  void _onBackBtnPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _loginBtnPressed(BuildContext context) {

    // TODO remove these two lines
    Navigator.popAndPushNamed(context, '/admin_panel');
    return;

    // Get email and password from input fields
    var email = _emailController.text;
    var password = _passwordController.text;

    // Submit email and password to Firebase auth
    var auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      Fluttertoast.showToast(
        msg: 'Login successful',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.popAndPushNamed(context, '/admin_panel');
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: 'Invalid email or password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(error);
    });
  }

  // Overrides
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _onBackBtnPressed(context),
        ),
        title: Text(
          AppStrings.inhaMasjidAdmin,
          style: GoogleFonts.manrope(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimensions.screenTitleFontSize,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [

                // Login screen icon on top
                const Icon(
                  Icons.admin_panel_settings,
                  size: AppDimensions.adminLoginIconFontSize,
                  color: AppColors.widgetPrimary,
                ),
                const SizedBox(height: 50),

                // Subtitle e.g., "Great to have you back!"
                Text(
                  AppStrings.loginPrompt,
                  style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Email input field (editable)
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: AppStrings.email,
                    hintStyle: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.cardBackgroundColor,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.cardButtonBackgroundColor,
                      ),
                    ),
                    fillColor: AppColors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10),

                // Password input field (editable)
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.password,
                    hintStyle: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.cardBackgroundColor,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.cardButtonBackgroundColor,
                      ),
                    ),
                    fillColor: AppColors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 15),

                // Login button
                ElevatedButton.icon(
                  onPressed: () => _loginBtnPressed(context),
                  icon: const Icon(Icons.login, color: AppColors.white),
                  label: Text(
                    AppStrings.login.toUpperCase(),
                    style: const TextStyle(color: AppColors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cardButtonBackgroundColor,
                    minimumSize: const Size(
                      double.infinity,
                      AppDimensions.donateButtonHeight,
                    ),
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
