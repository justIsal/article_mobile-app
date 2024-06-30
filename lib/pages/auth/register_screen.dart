import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:article_mobile_app/model/response_model.dart';
import 'package:article_mobile_app/services/user/user_services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  /* Membuat Instance User Services */
  final UserServices _userServices = UserServices();

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                    const Text("Already have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        )),
                    TextButton(
                      child: const Text("SIGN IN",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 50),
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
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
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
                  key: _registerFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Get started free",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Enter your detail below",
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: "username",
                            labelText: "username",
                            border: OutlineInputBorder(),
                            // prefixIcon: Icon(Icons.badge_outlined)
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "username harus di isi";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "email",
                            labelText: "email",
                            border: OutlineInputBorder(),
                            // prefixIcon: Icon(Icons.person_2_outlined)
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "email harus di isi";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "pasword",
                            labelText: "password",
                            border: OutlineInputBorder(),
                            // prefixIcon: Icon(Icons.lock_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "password harus di isi";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "confirm password",
                            labelText: "confirm password",
                            border: OutlineInputBorder(),
                            // prefixIcon: Icon(Icons.lock_outline),
                          ),
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return "Password and Confirm Password does not match";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              _onRegisterButtonTapped();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              backgroundColor: const Color(0xFF0A73D3),
                            ),
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void _onRegisterButtonTapped() async {
    if (_registerFormKey.currentState!.validate()) {
      /* register user ke API */
      final ResponseModel response = await _userServices.registerUser(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text);
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted && Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          });
          return AlertDialog(
            /* menampilkan pesan dari server */
            title: Text(response.status),
            content: Text(response.message),
          );
        },
      );

      if (response.status != "success") return;
      if (!mounted) return;
      Navigator.pop(context);
    }
  }
}
