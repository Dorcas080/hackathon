import 'package:e_commerce_app/screens/forgot_screen.dart';

import 'package:e_commerce_app/screens/navigation_screen.dart';
import 'package:e_commerce_app/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController =
      TextEditingController();

  bool isLoading = false;
  bool isObscure = true;
  bool disObscure = true;
  bool isValidPhoneNumber = true;
  var formStateKey = GlobalKey<FormState>();
  Future login() async {
    print("pressed");
    if (formStateKey.currentState!.validate()) {
      try {
        print("validated");
        print("Email : ${emailEditingController.text}");
        print("Password : ${passwordEditingController.text}");

        setState(() {
          isLoading = true;
        });
        var cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text,
        );

        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login Successfully"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationScreen()),
        );
      } on FirebaseException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? "Some Unknown error"),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: formStateKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 110),
                  Image.asset("assets/images/freed.png"),
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailEditingController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required, please enter your email";
                            } else if (!(value.contains("@") &&
                                    value.contains(".")) ||
                                value.length <= 6) {
                              return "Enter valid email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Enter Email",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: passwordEditingController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required, please enter your password";
                            } else if (value.length < 6) {
                              return "Password must be greater than six";
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Enter Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Color(0xFFDB3022),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        isLoading
                            ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            )
                            : ElevatedButton(
                              onPressed: login,
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(55),
                                backgroundColor: Color(0xFFDB3022),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                "Log In",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have an Account?",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Color(0xFFEf6969),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
