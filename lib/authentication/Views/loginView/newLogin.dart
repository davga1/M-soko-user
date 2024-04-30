import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/authentication/Views/loginView/google_auth.dart';
import 'package:m_soko/authentication/Views/loginView/login_new.dart';
import 'package:m_soko/authentication/Views/registerView/register_view.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/main.dart';

List userList = [];
void main() => runApp(const MaterialApp(
      home: loginPageNew(),
    ));

class loginPageNew extends StatefulWidget {
  const loginPageNew({super.key});

  @override
  State<loginPageNew> createState() => _loginPageNewState();
}

bool isObscured = true;
String email = '';
String password = '';
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _loginPageNewState extends State<loginPageNew> {
  void _emailControllerListener() {
    if (emailController.text.contains(' ')) {
      emailController.text = emailController.text.replaceAll(' ', '');
      setState(() {});
    }
  }

  void _passwordControllerListener() {
    if (passwordController.text.contains(' ')) {
      passwordController.text = passwordController.text.replaceAll(' ', '');
      setState(() {});
    }
  }

  @override
  void initState() {
    getList();
    email = '';
    password = '';
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailController.addListener(_emailControllerListener);
    passwordController.addListener(_passwordControllerListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //Image and text
        body: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/auth_header.png'),
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'Welcome to\nSokoni!',
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
              ],
            ),
            //main part
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  const Row(children: [
                    SizedBox(
                      width: 33,
                    ),
                    Text(
                      'Email',
                      textAlign: TextAlign.left,
                    ),
                  ]),
                  Container(
                      margin: EdgeInsets.fromLTRB(width / 13, 0, width / 13, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          if (value.contains('@gmail.com')) {
                            setState(() {
                              email = value;
                            });
                          } else {
                            setState(() {
                              email = '';
                            });
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: '   testuser1@gmail.com',
                            border: InputBorder.none),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(children: [
                    SizedBox(
                      width: 33,
                    ),
                    Text(
                      'Password',
                      textAlign: TextAlign.left,
                    ),
                  ]),
                  Container(
                      margin: EdgeInsets.fromLTRB(width / 13, 0, width / 13, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        obscureText: isObscured,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          if (value.length > 5) {
                            setState(() {
                              password = value;
                            });
                          } else {
                            setState(() {
                              password = '';
                            });
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObscured = !isObscured;
                                  });
                                },
                                icon: Icon(isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            hintText: '   CustomPassword123',
                            border: InputBorder.none),
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?      ',
                      style: TextStyle(color: Colors.lightBlue),
                    )),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(width / 13, 0, width / 13, 0),
              child: Row(
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
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
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
                GestureDetector(
                  onTap: () async {
                    try{
                    await signInWithGoogle();
                    }  on FirebaseAuthException catch(e){
                      print('${e.code}================================');
                    }
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
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(width / 13, 0, width / 13, 0),
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(ColorConstants.blue700),
                ),
                onPressed: () {
                  if (userList.contains(email)) {
                    try {
                      logInNew(email, password);
                    } on ProviderNotFoundException catch (e) {}
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Email or password are not correct');
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New Here?'),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegisterView(),
                    ));
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
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ));
  }
}

getList() async {
  QuerySnapshot snapshot;
  snapshot = await FirebaseFirestore.instance.collection('users').get();
  var docs = snapshot.docs;
  for (var doc in docs) {
    var data = doc.data() as Map;
    userList.add(data['email']);
  }
}
