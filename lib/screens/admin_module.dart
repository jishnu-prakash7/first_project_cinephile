// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firstprojectcinephile/models/movies.dart';
import 'package:firstprojectcinephile/screens/add_movie_screen.dart';
import 'package:firstprojectcinephile/screens/edit_screen.dart';
import 'package:firstprojectcinephile/screens/user_login_screen.dart';
import 'package:firstprojectcinephile/widgets/admin_panel_ref.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class AdminModule extends StatefulWidget {
  const AdminModule({super.key});

  @override
  State<AdminModule> createState() => _AdminModuleState();
}

class _AdminModuleState extends State<AdminModule> {
  late Box moviesBox;
  @override
  void initState() {
    moviesBox = Hive.box('movies');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Colors.black,
            title: appbarHeading('Admin Panel', 30),
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    logoutAlertDialog(context, signout);
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ))
            ],
          ),
        ),
        body: ValueListenableBuilder(
            valueListenable: moviesBox.listenable(),
            builder: (context, box, child) {
              return ListView.builder(
                  itemCount: moviesBox.length,
                  itemBuilder: (context, index) {
                    final movie = moviesBox.getAt(index) as movies;
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 235, 235, 235)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: const Color.fromARGB(
                                            255, 193, 193, 193)),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 120,
                                width: 160,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(movie.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${movie.title}(${DateFormat('yyyy').format(movie.releaseyear)})',
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Director :${movie.moviedirector}',
                                            style: GoogleFonts.ubuntu(
                                              textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                            softWrap: false,
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Text(
                                      'Language :${movie.movielanguage}',
                                      style: GoogleFonts.ubuntu(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating: movie.movierating,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 18,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                                Icons.star,
                                                color: Color.fromARGB(
                                                    255, 238, 182, 13),
                                              ),
                                          onRatingUpdate: (rating) {})),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return EditAndDeleteScreen(
                                              movie: movie,
                                              index: index,
                                            );
                                          }));
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          deletedialog(movie, context);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color:
                                              Color.fromARGB(255, 241, 81, 70),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }),
        floatingActionButton: FloatingActionButton.extended(
          splashColor: Colors.green,
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return addMovieScreen();
            }));
          },
          label: Text(
            'Movie',
            style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 19)),
          ),
          icon: const Icon(Icons.add, color: Colors.black, size: 30),
        ));
  }

  void signout(BuildContext ctx) async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return const UserLogin();
    }), (route) => false);
  }
}
