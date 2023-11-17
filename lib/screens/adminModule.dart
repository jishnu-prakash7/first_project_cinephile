// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:firstprojectcinephile/models/movies.dart';
import 'package:firstprojectcinephile/screens/addMovieScreen.dart';
import 'package:firstprojectcinephile/screens/editAndDeleteScreen.dart';
import 'package:firstprojectcinephile/screens/userLoginScreen.dart';
import 'package:firstprojectcinephile/widgets/mainRefactoring.dart';
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
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Admin Panel',
              style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.green)),
            ),
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    logoutAlertDialog(context, signout);
                  },
                  icon: Icon(Icons.logout))
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
                                    fit: BoxFit.fill,
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
                                                    textStyle: TextStyle(
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
                                              textStyle: TextStyle(
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
                                        textStyle: TextStyle(
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
                                          itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Color.fromARGB(
                                                    255, 238, 182, 13),
                                              ),
                                          onRatingUpdate: (rating) {})),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return EditAndDeleteScreen(
                                              movie: movie,
                                              index: index,
                                            );
                                          }));
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color:
                                              Color.fromARGB(255, 67, 187, 129),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'Delete Movie',
                                                    style: GoogleFonts.ubuntu(
                                                        textStyle: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black)),
                                                  ),
                                                  content: Text(
                                                      'Are you sure want to delete?',
                                                      style: GoogleFonts.ubuntu(
                                                          textStyle: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black))),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          'No',
                                                          style: GoogleFonts.ubuntu(
                                                              textStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black)),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          deleteMovie(movie);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('yes',
                                                            style: GoogleFonts.ubuntu(
                                                                textStyle: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black))))
                                                  ],
                                                );
                                              });
                                        },
                                        child: Icon(
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
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 19)),
          ),
          icon: Icon(Icons.add, color: Colors.black, size: 30),
        ));
  }

  void deleteMovie(movies movie) async {
    await movie.delete();
    // showSnackBar(context, 'Movie Deleted Succesfully', Colors.red);
  }

  void signout(BuildContext ctx) async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return UserLogin();
    }), (route) => false);
  }
}
