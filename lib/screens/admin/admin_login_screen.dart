import 'package:firstprojectcinephile/screens/admin/admin_module_screen.dart';
import 'package:firstprojectcinephile/screens/user/user_login_screen.dart';
import 'package:firstprojectcinephile/widgets/login_and_signup_ref.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({super.key});
  final _formKey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  RegExp get _nameRegex => RegExp(r'^[a-zA-Z ]+$');
  RegExp get _passwordRegex => RegExp(r'^(?=.*[0-9].*[0-9].*[0-9])[0-9]+$');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: maintitle(),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
                margin: const EdgeInsets.only(left: 60, right: 60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
                            'Admin',
                            style: GoogleFonts.ubuntu(
                                textStyle: const TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.w800)),
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
                              Icons.person,
                              'Name contain only alphabets',
                              _nameRegex),
                          textabovetextfield('Password'),
                          LoginTextformField(
                              'Enter Password',
                              'Password is needed !',
                              passwordcontroller,
                              TextInputType.number,
                              true,
                              Icons.lock,
                              'at least 3 characters Needed !',
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
                              final isvalid = _formKey.currentState?.validate();
                              final name = namecontroller.text;
                              final password = passwordcontroller.text;
                              if (isvalid!) {
                                if (name == 'jishnu' && password == '123') {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) {
                                    return const AdminModule();
                                  }), (route) => false);
                                }
                              }
                            },
                            child: Text(
                              'Login',
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white)),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return const UserLogin();
                            }));
                          },
                          child: Text('User ?',
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(fontSize: 16),
                                  color:
                                      const Color.fromARGB(255, 245, 63, 8))),
                        ),
                      )
                    ]),
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
