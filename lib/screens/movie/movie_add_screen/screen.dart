// ignore_for_file: camel_case_types

import 'package:firstprojectcinephile/screens/movie/movie_add_screen/widgets.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class addMovieScreen extends StatefulWidget {
  const addMovieScreen({super.key});

  @override
  State<addMovieScreen> createState() => _addMovieScreenState();
}

class _addMovieScreenState extends State<addMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final yearController = TextEditingController();
  final languageController = TextEditingController();
  final timeController = TextEditingController();
  final directorController = TextEditingController();
  final ratingcontroller = TextEditingController();
  final genreController = TextEditingController();
  final reviewcontroller = TextEditingController();
  final dateController = TextEditingController();
  final theaterController = TextEditingController();
  late Box moviesBox;

  @override
  void initState() {
    super.initState();
    moviesBox = Hive.box('movies');
  }

  String? selectedGenre;
  String? selectedLanguage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: appbarHeading('Add Movie', 25)),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  addmovieSection(
                      titleController: titleController,
                      dateController: dateController,
                      timeController: timeController,
                      directorController: directorController,
                      reviewcontroller: reviewcontroller,
                      theaterController: theaterController,
                      formKey: _formKey)
                ],
              ),
            )),
      ),
    );
  }
}
