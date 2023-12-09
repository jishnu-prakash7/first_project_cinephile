// ignore_for_file: use_build_context_synchronously

import 'package:firstprojectcinephile/main.dart';
import 'package:firstprojectcinephile/screens/admin/admin_login_screen.dart';
import 'package:firstprojectcinephile/screens/movie/home_screen/screen.dart';
import 'package:firstprojectcinephile/screens/user/user_signup_screen.dart';
import 'package:firstprojectcinephile/widgets/db_function.dart';
import 'package:firstprojectcinephile/widgets/login_and_signup_ref.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int flag = 0;

  late Box userBox;
  int? index;
  RegExp get _emailRegex => RegExp(r'^\S+@gmail\.com$');
  RegExp get _passwordRegex => RegExp(r'^(?=.*[0-9].*[0-9].*[0-9])[0-9]+$');

  @override
  void initState() {
    super.initState();
    userBox = Hive.box('user');
  }

  int? loggedInUserIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: maintitle(),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.13,
              ),
              Container(
                margin: const EdgeInsets.only(left: 50, right: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textabovetextfield('Email'),
                            LoginTextformField(
                                'Enter Email',
                                'Email is needed!',
                                emailcontroller,
                                TextInputType.emailAddress,
                                false,
                                Icons.email_sharp,
                                'Enter valid Email',
                                _emailRegex),
                            textabovetextfield('Password'),
                            LoginTextformField(
                                'Enter Password',
                                'Password is needed!',
                                passwordcontroller,
                                TextInputType.number,
                                true,
                                Icons.lock,
                                'Enter valid password',
                                _passwordRegex),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 21, 21, 21),
                                  fixedSize: const Size(200, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () async {
                                final isvalid =
                                    _formKey.currentState?.validate();
                                if (isvalid!) {
                                  final email =
                                      emailcontroller.text.toLowerCase();
                                  final password = passwordcontroller.text;

                                  for (var i = 0; i < userBox.length; i++) {
                                    final storedUser = getUserAt(i);
                                    if (storedUser.email.toLowerCase() ==
                                            email &&
                                        storedUser.password ==
                                            int.parse(password)) {
                                      loggedInUserIndex = i;
                                      checkLogin(context);
                                      setState(() {});
                                      flag = 0;
                                      break;
                                    } else {
                                      flag = 1;
                                    }
                                  }
                                  if (flag == 1) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Email or Password Wrong !',
                                                style: GoogleFonts.ubuntu(
                                                    color: Colors.red))));
                                  }
                                }
                              },
                              child: Text(
                                'login',
                                style: GoogleFonts.ubuntu(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.white)),
                              )),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'Dont have an Account?',
                                style: GoogleFonts.ubuntu(
                                    textStyle: const TextStyle(fontSize: 16),
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: 'Signup',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) {
                                      return const Signup();
                                    }));
                                  },
                                style: GoogleFonts.ubuntu(
                                    textStyle: const TextStyle(fontSize: 16),
                                    color:
                                        const Color.fromARGB(255, 14, 145, 44)),
                              ),
                            ]))),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return AdminLogin();
                            }));
                          },
                          child: Text('Admin ?',
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(fontSize: 16),
                                  color:
                                      const Color.fromARGB(255, 245, 63, 8))),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void checkLogin(BuildContext ctx) async {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.setBool(KEY, true);

    await sharedprefs.setInt('loggedInUserIndexKey', loggedInUserIndex!);

    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (context) {
      return const HomeScreen();
    }));
  }
}
