import 'package:flutter/material.dart';
import 'package:heart/screens/user/auth/forgot_password_screen.dart';
import 'package:heart/screens/user/auth/login_signup_screen.dart';
import 'package:heart/screens/user/auth/register_screen.dart';
import 'package:heart/screens/user/view/home_screen.dart';
import 'package:heart/screens/user/widgets/social_login.dart';
import 'package:heart/screens/user/widgets/text_field.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/patient.dart';
import '../../../services/auth_service.dart';
import '../../../services/patient_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final PatientService _patientService = PatientService();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _loadSavedUsername();
  }

  Future<void> _loadSavedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    _usernameController.text = prefs.getString('saved_username') ?? '';
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showSnackbar("Please fill in all fields");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final user = await _authService.login(username, password);
      if (user != null) {
        print("✅ Token: ${user.token}");

        // ✅ Lưu username để lần sau tự động nhập lại
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('saved_username', username);

        // ✅ Lấy thông tin bệnh nhân trước khi điều hướng
        final patientData = await _patientService.fetchPatientAPI(user.id, user.token);
        if (patientData != null) {
          final patient = Patient.fromJson(patientData);
          await _patientService.savePatientInfo(patient);
        } else {
          print("⚠️ Không tìm thấy bệnh nhân.");
        }

        // ✅ Chuyển hướng sau khi mọi thứ hoàn tất
        Navigator.pushReplacement(
          context,
          PageTransition(type: PageTransitionType.fade, child: HomeScreen()),
        );
      } else {
        _showSnackbar('Invalid username or password');
      }
    } catch (e) {
      _showSnackbar('An error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset("assets/icons/back2.png", height: 30),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: LoginSignupScreen()));
          },
        ),
        centerTitle: true,
        title: const Text(
          "Login",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 22,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 40),
            TextFieldWidget(
              controller: _usernameController,
              text: "Enter your username",
              icon: "assets/icons/person.png",
            ),
            const SizedBox(height: 5),
            TextFieldWidget(
              controller: _passwordController,
              text: "Enter your password",
              icon: "assets/icons/lock.png",
              isPassword: true,
              isPasswordVisible: _isPasswordVisible,
              onTogglePasswordVisibility: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: ForgotPassword()));
                  },
                  child: const Text(
                    "Forgot your password?",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 3, 190, 150),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 3, 190, 150),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: RegisterScreen()));
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 3, 190, 150),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1, color: Colors.grey),
            const SizedBox(height: 30),
            SocialLogin(logo: "assets/images/google.png", text: "Sign in with Google"),
            const SizedBox(height: 20),
            SocialLogin(logo: "assets/images/apple.png", text: "Sign in Apple"),
            const SizedBox(height: 20),
            SocialLogin(logo: "assets/images/facebook.png", text: "Sign in Facebook"),
          ],
        ),
      ),
    );
  }
}
