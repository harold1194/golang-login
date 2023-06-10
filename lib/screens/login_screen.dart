import 'package:flutter/material.dart';
import 'package:golang_login/auth/auth_provider.dart';
import 'package:golang_login/screens/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../routes/my_routes.dart';
import '../widgets/my_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isVisible = true;

  String _successMessage = '';
  String _errorMessage = '';

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      final String email = emailController.text;
      final String password = passwordController.text;

      // Perform the login request
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.login();
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        // Login successful, proceed to the next
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
            context, homeScreenRoute, (route) => false);
        setState(() {
          _successMessage = 'Login Successfull';
          _errorMessage = '';
        });
      } else {
        // Login failed, display error message

        setState(() {
          _errorMessage = 'Login Failed';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLogginIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLogginIn) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.login();

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        homeScreenRoute,
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: const MyAppBar(
        isAutoImplyLeading: false,
        title: 'Login',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  return value!.isEmpty ? "Please enter your email" : null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: isVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility))),
                validator: (value) {
                  return value!.isEmpty ? "Please enter your password" : null;
                },
              ),
              const SizedBox(height: 16.0),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                )),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.grey,
                      textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blueAccent,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
