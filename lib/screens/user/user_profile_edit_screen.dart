import 'dart:io';

import 'package:firstprojectcinephile/models/user.dart';
import 'package:firstprojectcinephile/screens/user/user_profile_screen.dart';
import 'package:firstprojectcinephile/widgets/db_function.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:firstprojectcinephile/widgets/user_profile_ref.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileEdit extends StatefulWidget {
  final User? userdetails;
  final int? index;
  const UserProfileEdit(
      {super.key, required this.userdetails, required this.index});

  @override
  State<UserProfileEdit> createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileEdit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namecontroller;

  late TextEditingController emailcontroller;

  late TextEditingController passwordcontroller;

  XFile? _selectedImage;

  RegExp get _emailRegex => RegExp(r'^\S+@gmail\.com$');
  RegExp get _nameRegex => RegExp(r'^[a-zA-Z ]+$');
  RegExp get _passwordRegex => RegExp(r'^(?=.*[0-9].*[0-9].*[0-9])[0-9]+$');
  late Box userBox;
  @override
  void initState() {
    super.initState();
    userBox = Hive.box('user');
    namecontroller = TextEditingController(text: widget.userdetails!.userName);
    emailcontroller = TextEditingController(text: widget.userdetails!.email);
    passwordcontroller =
        TextEditingController(text: widget.userdetails!.password.toString());
    _selectedImage = widget.userdetails!.image != null
        ? XFile(widget.userdetails!.image!)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Colors.black,
            title: appbarHeading('Edit Profile', 25),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      maxRadius: 60,
                      child: GestureDetector(
                          onTap: () async {
                            XFile? pickimage = await pickImageFormgallery();
                            setState(() {
                              _selectedImage = pickimage;
                            });
                          },
                          child: _selectedImage != null
                              ? ClipOval(
                                  child: Image.file(
                                    File(_selectedImage!.path),
                                    fit: BoxFit.cover,
                                    width: 140,
                                    height: 140,
                                  ),
                                )
                              : const Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _selectedImage != null ? 'Edit Image' : 'Add Image',
                      style: GoogleFonts.ubuntu(
                          textStyle:
                              const TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  textformfieldUserEdit('Name', namecontroller, _nameRegex,
                      'Name is required', 'Name only contain alphabets'),
                  textformfieldUserEdit('Email', emailcontroller, _emailRegex,
                      'Email is required', 'Enter a valid Email !'),
                  textformfieldUserEdit(
                      'Password',
                      passwordcontroller,
                      _passwordRegex,
                      'Password is Needed !',
                      'Password contain atleast 3 charecters'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30, top: 50),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(300, 50)),
                      onPressed: () {
                        validate();
                      },
                      child: Text('Save',
                          style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(fontSize: 20),
                              color: Colors.black)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validate() {
    final isvalid = _formKey.currentState?.validate();
    if (isvalid!) {
      final value = User(
          image: _selectedImage?.path,
          userName: namecontroller.text.trim(),
          email: emailcontroller.text,
          password: int.parse(passwordcontroller.text.trim()));

      updateUserInDb(value, widget.index!);

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const UserProfileScreen();
      }));
      showSnackBar(context, 'Details Edited Succesfully', Colors.teal);
    }
  }
}
