// ignore_for_file: use_build_context_synchronously

import 'package:allection/models/snackbar.dart';
import 'package:allection/services/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isSubmitted = false;

  Future<String> loginUser() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    String result = await MongoDatabase.fetchLoginUser(username, password);

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
                          "Sign in",
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
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TextFormField Email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 48),
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
                          onChanged: (value) => setState(() {
                            if (_isSubmitted) {
                              _isSubmitted = false;
                            }
                          }),
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
                                _isSubmitted && usernameController.text.isEmpty
                                ? "Invalid username"
                                : null,
                          ),
                          onTapOutside: (_) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        // TextFormField Password
                        SizedBox(height: 32),
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
                                _isSubmitted && passwordController.text.isEmpty
                                ? "Invalid password"
                                : null,
                          ),
                          onTapOutside: (_) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      ],
                    ),

                    // Esqueci da minha password e botão de Sign In
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: AllColors.secondaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isSubmitted = true;
                            });
                            if (usernameController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              return;
                            }
                            try {
                              final result = await loginUser();
                              if (!mounted) return;
                              if (result.contains(
                                'Incorrect username or password',
                              )) {
                                CustomSnackBar.show(
                                  context,
                                  message: 'Incorrect username or password',
                                  isError: true,
                                );
                              } else {
                                context.go('/home');
                              }
                            } catch (e) {
                              if (mounted) {
                                CustomSnackBar.show(
                                  context,
                                  message: 'Login failed: $e',
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
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.go('/register');
                              },
                              child: Text(
                                "Sign Up",
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
