import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_soko/authentication/Views/registerView/register_new.dart';
import 'package:m_soko/common/colors.dart';

TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController passwordController2 = TextEditingController();
dynamic usernameErrorText;
dynamic emailErrorText;
dynamic passwordErrorText;

String username = '';
String email = '';
String password = '';

bool passwordIsTheSame = false;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // header part
          Image.asset('assets/register_header.png'),

          Container(
            margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Create new\naccount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 35,
                  height: 8,
                  decoration: BoxDecoration(
                    color: ColorConstants.orange500,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
          ),

          // main part
          Container(
            margin: const EdgeInsets.fromLTRB(30, 250, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //name
                const Text(
                  'Full name',
                  textAlign: TextAlign.right,
                ),
                TextField(
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  enableSuggestions: true,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        usernameErrorText = null;
                      });
                    } else if (value.length < 3) {
                      setState(() {
                        username = '';
                        usernameErrorText = 'Please write valid name';
                      });
                    } else {
                      setState(() {
                        usernameErrorText = null;
                        username = value;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    errorText: usernameErrorText,
                    hintText: 'Enter your username',
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.blue700),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0),
                  ),
                ),

                // email
                const SizedBox(height: 8),
                const Text(
                  'Email',
                  textAlign: TextAlign.right,
                ),
                TextField(
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        email = '';
                        emailErrorText = null;
                      });
                    } else if (value.contains('@gmail.com')) {
                      setState(() {
                        email = value;
                        emailErrorText = null;
                      });
                    } else {
                      setState(() {
                        email = '';
                        emailErrorText = 'Email is invalid';
                      });
                    }
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    errorText: emailErrorText,
                    hintText: 'Enter your email address',
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.blue700),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0),
                  ),
                ),

                // password
                const SizedBox(height: 8),
                const Text('Password'),
                TextField(
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        passwordErrorText = null;
                      });
                    } else if (!value.contains(RegExp('[A-Z]'))) {
                      setState(() {
                        password = '';
                        passwordErrorText =
                            'Should contain at least one uppercase letter';
                      });
                    }
                    else if (value.length < 6) {
                      setState(() {
                        password = '';
                        passwordErrorText = 'Should have at least 6 characters';
                      });
                    } else {
                      setState(() {
                        passwordErrorText = null;
                        password = value;
                      });
                    }
                  },
                  controller: passwordController,
                  // obscureText:
                  decoration: InputDecoration(
                    errorText: passwordErrorText,
                    hintText: 'Enter your password',
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.blue700),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.visibility), onPressed: () {}),
                  ),
                ),

                // confirm password
                const SizedBox(height: 8),
                const Text('Confirm Password'),
                TextField(
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        passwordErrorText = null;
                      });
                    } else if (value == password && value != '') {
                      setState(() {
                        passwordIsTheSame = true;
                        passwordErrorText = null;
                      });
                    } else {
                      setState(() {
                        passwordErrorText = 'Passwords are not the same';
                      });
                    }
                  },
                  controller: passwordController2,
                  // obscureText: ,
                  decoration: InputDecoration(
                    hintText: 'Confirm your password',
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.blue700),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0,
                    ),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.visibility), onPressed: () {}),
                  ),
                ),

                // seperator
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('or'),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                // social login
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(msg: 'Facebook signup');
                      },
                      child: Container(
                        // padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.asset(
                          'assets/fb_sign.png',
                        ),
                      ),
                    ),
                    const SizedBox(width: 0),
                    GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(msg: 'Google signup');
                      },
                      child: Container(
                        // padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.asset(
                          'assets/google_sign.png',
                        ),
                      ),
                    ),
                  ],
                ),
                // Sign Up button
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorConstants.blue700),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              createUser(username, email, password);
                            },
                            child: const SizedBox(
                              height: 35,
                              child: Center(
                                child: Text(
                                  'Sign Up!',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // switch to login
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'By signing up, you agree to our ',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms And Policy',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Implement your navigation or action here
                                log('Navigate to Terms And Policy');
                              },
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Have an account?'),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                              const BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
