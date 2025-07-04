// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screens/login_screen.dart';
import 'package:e_commerce_app/screens/navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameEditingController = TextEditingController();
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
  Future register() async {
    if (formStateKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        var cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text,
        );
        await FirebaseFirestore.instance
            .collection("users")
            .doc(cred.user?.uid)
            .set({
              "name": nameEditingController,
              "email": emailEditingController.text,
              "number": int.tryParse(numberEditingController.text),
              "password": passwordEditingController.text,
            });
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registered Successfully"),
            backgroundColor: Colors.green,
          ),
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
                  SizedBox(height: 50),
                  Image.asset("assets/images/freed.png"),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameEditingController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name is required, please enter your Full Name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Enter Name",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(height: 15),
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
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: numberEditingController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            } else if (!isValidPhoneNumber) {
                              return 'Enter a valid phone number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Enter Phone Number",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
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
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              child: Icon(
                                isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: confirmPasswordEditingController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Confirm Password is required, please confirm your password";
                            } else if (value !=
                                passwordEditingController.text) {
                              return "Confirm Password";
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  disObscure = !disObscure;
                                });
                              },
                              child: Icon(
                                disObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 40),

                        isLoading
                            ? Center(child: CircularProgressIndicator())
                            : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: register,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(55),
                                  backgroundColor: Color(0xFFDB3022),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an Account?",
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
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login In",
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
