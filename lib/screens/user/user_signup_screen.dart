import 'package:firstprojectcinephile/models/user.dart';
import 'package:firstprojectcinephile/screens/user/user_login_screen.dart';
import 'package:firstprojectcinephile/widgets/db_function.dart';
import 'package:firstprojectcinephile/widgets/login_and_signup_ref.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  final namecontroller = TextEditingController();

  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');
  RegExp get _nameRegex => RegExp(r'^[a-zA-Z][a-zA-Z ]*$');
  RegExp get _passwordRegex => RegExp(r'^(?=.*[0-9].*[0-9].*[0-9])[0-9]+$');

  late Box userBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box('user');
  }

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
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.1,
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
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Signup',
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
                            textabovetextfield('Name'),
                            LoginTextformField(
                                'Enter Name',
                                'Name is needed !',
                                namecontroller,
                                TextInputType.name,
                                false,
                                Icons.person_2_sharp,
                                'Name only contain alphabets',
                                _nameRegex),
                            textabovetextfield('Email'),
                            LoginTextformField(
                                'Enter Email',
                                'Email is needed !',
                                emailcontroller,
                                TextInputType.emailAddress,
                                false,
                                Icons.email_sharp,
                                'Valid Email is Needed !',
                                _emailRegex),
                            textabovetextfield('Password'),
                            LoginTextformField(
                                'Enter Password',
                                'Password is needed !',
                                passwordcontroller,
                                TextInputType.number,
                                true,
                                Icons.lock,
                                'Password contain Atleast 3 Charecters',
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
                              onPressed: () {
                                final isvalid =
                                    _formKey.currentState?.validate();
                                if (isvalid!) {
                                  addUserToDb(User(
                                      userName: namecontroller.text.trim(),
                                      email: emailcontroller.text.trim(),
                                      password: int.parse(
                                          passwordcontroller.text.trim())));
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                    return const UserLogin();
                                  }));
                                }
                              },
                              child: Text(
                                'signup',
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
                                text: 'Already have an Account? ',
                                style: GoogleFonts.ubuntu(
                                    textStyle: const TextStyle(fontSize: 16),
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: 'Login',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) {
                                      return const UserLogin();
                                    }));
                                  },
                                style: GoogleFonts.ubuntu(
                                    textStyle: const TextStyle(fontSize: 16),
                                    color:
                                        const Color.fromARGB(255, 36, 171, 33)),
                              ),
                            ]))),
                      ]),
                    ),
                  ))
            ]),
          ),
        ));
  }
}
