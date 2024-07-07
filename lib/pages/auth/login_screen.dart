import 'package:article_mobile_app/pages/home/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:article_mobile_app/pages/auth/register_screen.dart';
import 'package:article_mobile_app/services/auth/auth_services.dart';

import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthServices _authServices = AuthServices();

  bool isObscure = true;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 0.6,
            colors: [
              Color.fromARGB(255, 126, 182, 235),
              Color(0xFF0A73D3),
            ],
          ),
        ),
        child: Stack(
          children: [
            const SizedBox(height: 50),
            Container(
              padding: EdgeInsets.only(top: 30, right: 10),
              height: 400,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Text("Don’t have an account?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          )),
                      TextButton(
                        child: const Text("SIGN UP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 40),
                    // height: 200,
                    child: Text("Readss",
                        style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold))),
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                    widthFactor: 0.95,
                    heightFactor: 0.72,
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 131, 180, 245),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  20.0), // Radius sisi kiri atas
                              topRight: Radius.circular(
                                  20.0), // Radius sisi kanan atas
                            ))))),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                widthFactor: 1.0,
                heightFactor: 0.7,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white, // Warna latar belakang
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0), // Radius sisi kiri atas
                      topRight: Radius.circular(20.0), // Radius sisi kanan atas
                    ),
                  ), // Warna latar belakang
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Enter your detail below",
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "input email",
                            labelText: "email",
                            fillColor: Color(0xFAFAFA),
                            filled: true,
                            border: OutlineInputBorder(),
                            // prefixIcon: Icon(Icons.person_2_outlined),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                            hintText: "input password",
                            labelText: "password",
                            border: const OutlineInputBorder(),
                            // prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: isObscure
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined),
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.pushReplacementNamed(context, '/home');
                              _onLoginButtonTapped();
                            },
                            // onPressed: _onLoginButtonTapped,
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                backgroundColor: const Color(0xFF0A73D3)),

                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onLoginButtonTapped() async {
    final result = await _authServices.login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted && Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
          }
        });
        return AlertDialog(
          title: Text(result.status),
          content: Text(result.message),
        );
      },
    );

    if (result.status == "success" && mounted) {
      /* pindah ke halaman notes page jika  success */
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Navigation()),
      );
    }
  }
}
