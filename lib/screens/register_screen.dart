// ignore_for_file: use_build_context_synchronously

import 'package:allection/models/snackbar.dart';
import 'package:allection/services/db_helper.dart';
import 'package:allection/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _isSubmitted = false;

  final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
    r"[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
    r"(?:\.[a-zA-Z]{2,})+$",
  );

  bool get _isEmailValid => _emailRegex.hasMatch(emailController.text);

  Future<String> registerUser() async {
    String email = emailController.text.trim();
    String password1 = passwordController.text;
    String password2 = confirmPasswordController.text;

    if (email.isEmpty || !_isEmailValid) {
      throw 'Please enter a valid email';
    }
    if (password1.isEmpty || password1.length < 6) {
      throw 'Password must be at least 6 characters';
    }
    if (password1 != password2) {
      throw 'Passwords do not match';
    }

    final password = password1;

    final existingUser = await MongoDatabase.fetchUser(email);
    if (existingUser.isNotEmpty && existingUser != 'null') {
      throw 'Email is already registered';
    }

    final result = await MongoDatabase.insertUser(email, password);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: FractionalOffset.center,
            colors: [AllColors.primaryColor, AllColors.secondaryColor],
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                  child: SizedBox(
                    height: 134 + View.of(context).padding.top,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome!",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Container Com os TextFormFields
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: Colors.white,
                ),
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(24, 14, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TextFormField Email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 14),
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 15,
                            color: AllColors.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          onChanged: (value) => setState(() {}),
                          decoration: InputDecoration(
                            hintText: "Insert your email",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 12,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AllColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AllColors.primaryColor,
                                width: 2,
                              ),
                            ),
                            suffixIcon: _isEmailValid
                                ? Icon(Icons.check)
                                : null,
                            suffixIconColor: _isEmailValid
                                ? Colors.green
                                : null,
                            errorText:
                                emailController.text.isEmpty && _isSubmitted ||
                                    _isEmailValid
                                ? "Invalid email address"
                                : null,
                          ),
                          onTapOutside: (_) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        SizedBox(height: 14),

                        //Username TextFormField
                        Text(
                          "Username",
                          style: TextStyle(
                            fontSize: 15,
                            color: AllColors.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextFormField(
                          controller: usernameController,
                          onChanged: (value) => setState(() {}),
                          decoration: InputDecoration(
                            hintText: "Insert your username",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 12,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AllColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AllColors.primaryColor,
                                width: 2,
                              ),
                            ),
                            errorText:
                                usernameController.text.isEmpty && _isSubmitted
                                ? "Invalid username"
                                : null,
                          ),
                          onTapOutside: (_) {
                            FocusScope.of(context).unfocus();
                          },
                        ),

                        // TextFormField Password
                        SizedBox(height: 14),
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 15,
                            color: AllColors.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextFormField(
                          obscureText: _obscureText,
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Insert your password",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 12,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AllColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AllColors.primaryColor,
                                width: 2,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: _obscureText
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            errorText:
                                passwordController.text.length >= 6 ||
                                    passwordController.text.isEmpty &&
                                        _isSubmitted
                                ? "Password must be at least 6 characters"
                                : null,
                          ),
                          onTapOutside: (_) {
                            FocusScope.of(context).unfocus();
                          },
                        ),

                        // TextFormField Confirm Password
                        SizedBox(height: 14),
                        Text(
                          "Confirm Password",
                          style: TextStyle(
                            fontSize: 15,
                            color: AllColors.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextFormField(
                          obscureText: _obscureText2,
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            hintText: "Confirm your password",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 12,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AllColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AllColors.primaryColor,
                                width: 2,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: _obscureText2
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureText2 = !_obscureText2;
                                });
                              },
                            ),
                            errorText:
                                _isSubmitted &&
                                    (confirmPasswordController.text ==
                                            passwordController.text ||
                                        confirmPasswordController.text.isEmpty)
                                ? "Passwords do not match"
                                : null,
                          ),
                          onTapOutside: (_) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      ],
                    ),

                    // Botão de Sign In
                    Column(
                      children: [
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              setState(() {
                                _isSubmitted = true;
                              });
                              final message = await registerUser();
                              if (!mounted) return;
                              CustomSnackBar.show(
                                context,
                                message: message,
                                isError: false,
                              );
                              context.go('/login');
                            } catch (e) {
                              if (mounted) {
                                CustomSnackBar.show(
                                  context,
                                  message: '$e',
                                  isError: true,
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AllColors.primaryColor,
                            minimumSize: Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Redicirecionar para o Sign Up
                    Column(
                      children: [
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.go('/login');
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: AllColors.secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
