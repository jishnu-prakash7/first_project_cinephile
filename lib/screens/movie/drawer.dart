// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firstprojectcinephile/models/user.dart';
import 'package:firstprojectcinephile/screens/movie/about_us_screen.dart';
import 'package:firstprojectcinephile/screens/movie/movie_watchlist_screen/screen.dart';
import 'package:firstprojectcinephile/screens/movie/privacy_policy_screen.dart';
import 'package:firstprojectcinephile/screens/movie/terms_and_conditions_screen.dart';
import 'package:firstprojectcinephile/screens/user/user_profile_screen.dart';
import 'package:firstprojectcinephile/widgets/db_function.dart';
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
    final user = getUserAt(loggedInUserIndex!);
    setState(() {
      loggedInUser = user;
      index = loggedInUserIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      child: ValueListenableBuilder(
          valueListenable: userBox.listenable(),
          builder: (context, box, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 40, bottom: 30),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Hello',
                            style: GoogleFonts.ubuntu(
                                textStyle: const TextStyle(
                                    fontSize: 25, color: Colors.teal))),
                        TextSpan(
                            text: ',${loggedInUser?.userName}',
                            style: GoogleFonts.ubuntu(
                                textStyle: const TextStyle(
                                    fontSize: 25, color: Colors.white)))
                      ]))),
                  Container(
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
                  DrawerListTile(
                      icon: Icons.bookmark,
                      text: 'WATCHLIST',
                      onTap: () {
                        return Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const WatchlistScreen();
                        }));
                      }),
                  DrawerListTile(
                      icon: Icons.person,
                      text: 'PROFILE',
                      onTap: () {
                        return Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const UserProfileScreen();
                        }));
                      }),
                  DrawerListTile(
                    icon: Icons.privacy_tip,
                    text: 'PRIVACY POLICY',
                    onTap: () {
                      return Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const privacyPolicyScreen();
                      }));
                    },
                  ),
                  DrawerListTile(
                    icon: Icons.edit_document,
                    text: 'TERMS & CONDITIONS',
                    onTap: () {
                      return Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const TermsAndConditionsScreen();
                      }));
                    },
                  ),
                  DrawerListTile(
                      icon: FontAwesomeIcons.copyright,
                      text: 'ABOUT US',
                      onTap: () {
                        return Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const aboutUsScreen();
                        }));
                      }),
                  DrawerListTile(
                      textcolor: Colors.red,
                      iconColor: Colors.red,
                      icon: Icons.logout,
                      text: 'LOGOUT',
                      onTap: () {
                        logoutAlertDialog(context, signout);
                      }),
                  const Center(
                      child: Text(
                    'Version-2.0.1',
                    style: TextStyle(color: Color.fromARGB(255, 193, 191, 191)),
                  ))
                ],
              ),
            );
          }),
    );
  }
}
