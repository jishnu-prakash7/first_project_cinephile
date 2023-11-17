// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, use_key_in_widget_constructors

import 'dart:io';

import 'package:firstprojectcinephile/models/movies.dart';
import 'package:firstprojectcinephile/screens/adminModule.dart';
import 'package:firstprojectcinephile/widgets/addAndEditMovie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class addMovieScreen extends StatefulWidget {
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
  final dateFocusNode = FocusNode();

  XFile? _selectedImage;
  dynamic movieRating = 0.0;

  @override
  void dispose() {
    dateController.dispose();
    dateFocusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  late Box moviesBox;

  @override
  void initState() {
    super.initState();
    moviesBox = Hive.box('movies');
  }

  Future<XFile?> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return XFile(pickedImage.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          'Add Movie',
          style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Colors.green)),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addAndEditMovieTitile('Thumbnail'),
                  Container(
                      height: 230,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          XFile? pickimage = await _pickImageFromCamera();
                          setState(() {
                            _selectedImage = pickimage;
                          });
                        },
                        child: _selectedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(_selectedImage!.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(Icons.add_a_photo, color: Colors.white),
                      )),
                  addAndEditMovieTitile('Movie Title'),
                  addAndEditMovieTextField('Enter title', titleController,
                      'Title is needed', TextInputType.name),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addAndEditMovieTitile('Release Date'),
                          Container(
                            width: 170,
                            decoration: BoxDecoration(),
                            child: Column(
                              children: [
                                TextFormField(
                                  focusNode: dateFocusNode,
                                  readOnly: true,
                                  onTap: () {
                                    dateFocusNode.requestFocus();
                                    _selectDate(context);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Date is Needed';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: dateController,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                  decoration: InputDecoration(
                                      fillColor:
                                          Color.fromARGB(255, 39, 38, 38),
                                      filled: true,
                                      contentPadding: EdgeInsets.only(left: 13),
                                      hintText: 'Select Date',
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.5),
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addAndEditMovieTitile('Language'),
                          addAndEditMovieTextField(
                              'Enter language',
                              languageController,
                              'language is needed',
                              TextInputType.name)
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addAndEditMovieTitile('Runtime'),
                          addAndEditMovieTextField(
                              'Enter runtime',
                              timeController,
                              'runtime is needed',
                              TextInputType.number)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addAndEditMovieTitile('Director'),
                          addAndEditMovieTextField(
                              'Enter director',
                              directorController,
                              'director is needed',
                              TextInputType.name)
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addAndEditMovieTitile('Rating'),
                          RatingBar.builder(
                            unratedColor: Colors.grey,
                            initialRating: movieRating,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                movieRating = rating;
                              });
                            },
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addAndEditMovieTitile('Genre'),
                          addAndEditMovieTextField(
                              'eg:Action,Comedy',
                              genreController,
                              'genre is needed',
                              TextInputType.name)
                        ],
                      ),
                    ],
                  ),
                  addAndEditMovieTitile('Review'),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.multiline,
                    controller: reviewcontroller,
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is needed';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 39, 38, 38),
                        filled: true,
                        hintText: 'Write review...',
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 189, 188, 188)),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: Size(160, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {
                              addmovie();
                            },
                            child: Text(
                              'Submit',
                              style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black)),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  void addmovie() {
    final isValid = _formKey.currentState?.validate();
    if (isValid!) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "You must select an Image",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
        return;
      } else if (movieRating == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "You must select Rating",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
        return;
      } else {
        moviesBox.add(movies(
            title: titleController.text.trim(),
            releaseyear: DateFormat('dd-MM-yyyy').parse(dateController.text),
            movielanguage: languageController.text.trim(),
            time: int.parse(timeController.text.trim()),
            moviedirector: directorController.text.trim(),
            movierating: movieRating,
            moviegenre: genreController.text.trim(),
            review: reviewcontroller.text.trim(),
            imageUrl: _selectedImage!.path));

        titleController.clear();
        dateController.clear();
        languageController.clear();
        timeController.clear();
        directorController.clear();
        ratingcontroller.clear();
        genreController.clear();
        reviewcontroller.clear();
        setState(() {
          _selectedImage = null;
        });

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return AdminModule();
        }), (route) => false);
        // showSnackBar(context, 'Movie Added Succesfully', Colors.teal);
      }
    }
  }
}
