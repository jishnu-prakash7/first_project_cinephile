// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firstprojectcinephile/screens/movie/movie_edit_screen/screen.dart';
import 'package:firstprojectcinephile/widgets/admin_module_ref.dart';
import 'package:firstprojectcinephile/widgets/db_function.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
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
          title: appbarHeading('Admin Panel', 28),
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
                  final movie = getMovieAt(index);
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
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
                                                child: adminpanelDetailsText(
                                                    '${movie.title}(${DateFormat('yyyy').format(movie.releaseyear)})',
                                                    18,
                                                    FontWeight.w700)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: adminpanelDetailsText(
                                                'Director :${movie.moviedirector}',
                                                15,
                                                FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: adminpanelDetailsText(
                                          'Language :${movie.movielanguage}',
                                          15,
                                          FontWeight.w500)),
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: ratingbar(movie.movierating)),
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
                                          deletedialog(movie, context,index);
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
                    ),
                  );
                });
          }),
      floatingActionButton: adminPanelFloatingActionButton(context),
    );
  }
}
