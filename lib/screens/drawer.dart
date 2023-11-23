// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firstprojectcinephile/models/user.dart';
import 'package:firstprojectcinephile/screens/user_login_screen.dart';
import 'package:firstprojectcinephile/screens/user_profile_screen.dart';
import 'package:firstprojectcinephile/widgets/drawer_ref.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  late Box userBox;
  User? loggedInUser;
  late int index;

  @override
  void initState() {
    super.initState();
    getuser();
    userBox = Hive.box('user');
  }

  getuser() async {
    final sharedprefs = await SharedPreferences.getInstance();
    final loggedInUserIndex = sharedprefs.getInt('loggedInUserIndexKey');
    final user = userBox.getAt(loggedInUserIndex!) as User;
    setState(() {
      loggedInUser = user;
      index = loggedInUserIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 40, bottom: 30),
            child: Text(
              'Welcome,${loggedInUser?.userName}',
              style: GoogleFonts.ubuntu(
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 25)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40, left: 10),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: CircleAvatar(
                backgroundImage: loggedInUser?.image != null
                    ? FileImage(File(loggedInUser!.image!))
                    : const AssetImage('assets/images/man.png')
                        as ImageProvider,
                maxRadius: 50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DrawerListTile(
              icon: Icons.home,
              text: 'H O M E',
              onTap: () {
                return Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: DrawerListTile(
                  icon: Icons.person,
                  text: 'P R O F I L E',
                  onTap: () {
                    return Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const UserProfileScreen();
                    }));
                  })),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: DrawerListTile(
                  icon: FontAwesomeIcons.copyright,
                  text: 'A B O U T',
                  onTap: () {
                    return Navigator.of(context).pop();
                  })),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: DrawerListTile(
                  iconColor: Colors.red,
                  icon: Icons.logout,
                  text: 'L O G O U T',
                  onTap: () {
                    logoutAlertDialog(context, signout);
                  })),
        ],
      ),
    );
  }
}
