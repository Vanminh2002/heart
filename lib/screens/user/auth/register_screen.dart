import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:heart/screens/user/auth/login_screen.dart';
import 'package:heart/screens/user/widgets/text_field.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import '../../../models/common.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isAgree = false;
  bool _isPasswordVisible = false; // Thêm biến để ẩn/hiện mật khẩu

  // Hàm điều hướng đến màn hình đăng nhập
  void _navigateToLogin() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        child: const LoginScreen(),
      ),
    );
  }

  // Hàm xử lý đăng ký
  void _register() async {
    final email = _emailController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    if (!_isAgree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must agree to the terms and conditions")),
      );
      return;
    }

    final payload = {
      "email": email,
      "username": username,
      "password": password,
      "role": "patient",
    };

    try {
      final response = await http.post(
        Uri.parse('${Common.domain}/patient'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration successful")),
        );
        _navigateToLogin();
      } else {
        final error = responseData['message'] ?? "Registration failed";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset("assets/icons/back2.png", height: 30, width: 30),
          onPressed: _navigateToLogin,
        ),
        title: const Text(
          "Sign up",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Email
            TextFieldWidget(
              text: "Enter your email",
              icon: "assets/icons/email.png",
              controller: _emailController,

            ),
            const SizedBox(height: 5),

            // Username
            TextFieldWidget(
              text: "Enter your name",
              icon: "assets/icons/person.png",
              controller: _usernameController,
            ),
            const SizedBox(height: 5),

            // Password
            TextFieldWidget(
              text: "Enter your password",
              icon: "assets/icons/lock.png",
              controller: _passwordController,
              isPassword: true,
              isPasswordVisible: _isPasswordVisible,
              onTogglePasswordVisibility: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),

            // Checkbox điều khoản
            Row(
              children: [
                Checkbox(
                  value: _isAgree,
                  onChanged: (bool? value) {
                    setState(() {
                      _isAgree = value ?? false;
                    });
                  },
                ),
                const Text(
                  "I agree to the terms and conditions",
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Nút đăng ký
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 3, 190, 150),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Create account",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Chuyển hướng đến trang đăng nhập
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                GestureDetector(
                  onTap: _navigateToLogin,
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 3, 190, 150),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
