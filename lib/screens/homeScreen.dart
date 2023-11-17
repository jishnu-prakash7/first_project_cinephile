// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:io';

import 'package:firstprojectcinephile/screens/detailsScreen.dart';
import 'package:firstprojectcinephile/screens/userLoginScreen.dart';
import 'package:firstprojectcinephile/widgets/mainRefactoring.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  List<dynamic> searchMovie = [];

  late Box moviesBox;

  void search() {
    String query = searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      searchMovie = moviesBox.values
          .where((movie) =>
              movie.title.toLowerCase().contains(query) ||
              movie.releaseyear.toString().contains(query))
          .toList();
    } else {
      searchMovie = List.from(moviesBox.values);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    moviesBox = Hive.box('movies');
    searchMovie = List.from(moviesBox.values);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: maintitle(),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 233, 230, 230)),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 350,
                height: 45,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      search();
                    });
                  },
                  controller: searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30)),
                      contentPadding: EdgeInsets.all(0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 41, 41, 41)),
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Color.fromARGB(255, 41, 41, 41),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: const Color.fromARGB(255, 209, 207, 207),
                      ),
                      hintText: 'Search Movies',
                      hintStyle: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 223, 222, 222))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
            )),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 21, 21, 21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Home',
                  style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 201, 200, 200))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Profile',
                style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 201, 200, 200))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'About',
                style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(255, 201, 200, 200))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  logoutAlertDialog(context, signout);
                  // showDialog(
                  //     context: context,
                  //     builder: (ctx) {
                  //       return AlertDialog(
                  //         title: Text(
                  //           'Logout',
                  //           style: GoogleFonts.ubuntu(),
                  //         ),
                  //         content: Text(
                  //           'Areyou sure want to logout?',
                  //           style: GoogleFonts.ubuntu(),
                  //         ),
                  //         actions: [
                  //           TextButton(
                  //               onPressed: () {
                  //                 signout(context);
                  //               },
                  //               child: Text(
                  //                 'Yes',
                  //                 style: GoogleFonts.ubuntu(
                  //                     textStyle:
                  //                         TextStyle(color: Colors.black)),
                  //               )),
                  //           TextButton(
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //               child: Text('No',
                  //                   style: GoogleFonts.ubuntu(
                  //                       textStyle:
                  //                           TextStyle(color: Colors.black))))
                  //         ],
                  //       );
                  //     });
                },
                child: Text(
                  'Logout',
                  style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 201, 200, 200))),
                ),
              ),
            ),
          ],
        ),
      ),
      body: searchMovie.isEmpty
          ? Center(
              child: Text(
                'No Movies Found',
                style: GoogleFonts.ubuntu(color: Colors.white),
              ),
            )
          : ListView.builder(
              // reverse: true,
              itemCount: searchMovie.length,
              itemBuilder: (context, index) {
                final movie = searchMovie[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return DetailsScreen(
                              movie: movie,
                            );
                          }));
                        },
                        child: SizedBox(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(movie.imageUrl),
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                movie: movie,
                              );
                            }));
                          },
                          child: Row(
                            children: [
                              Text(
                                '${movie.title} (${DateFormat('yyyy').format(movie.releaseyear)})',
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
    ));
  }

  void signout(BuildContext ctx) async {
    final sharedpref = await SharedPreferences.getInstance();
    await sharedpref.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return UserLogin();
    }), (route) => false);
  }
}
