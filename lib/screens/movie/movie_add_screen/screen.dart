// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:firstprojectcinephile/screens/movie/movie_add_screen/widgets.dart';
import 'package:firstprojectcinephile/screens/movie/function.dart';
import 'package:firstprojectcinephile/widgets/add_and_edit_movie_ref.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

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
                  // addAndEditMovieTitile('Thumbnail'),
                  // Container(
                  //     height: 230,
                  //     width: MediaQuery.sizeOf(context).width,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.grey),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: GestureDetector(
                  //       onTap: () async {
                  //         XFile? pickimage = await pickImageFormgallery();
                  //         setState(() {
                  //           _selectedImage = pickimage;
                  //         });
                  //       },
                  //       child: _selectedImage != null
                  //           ? ClipRRect(
                  //               borderRadius: BorderRadius.circular(10),
                  //               child: Image.file(
                  //                 File(_selectedImage!.path),
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             )
                  //           : const Icon(Icons.add_a_photo,
                  //               color: Colors.white),
                  //     )),
                  // addAndEditMovieTitile('Movie Title'),
                  // addAndEditMovieTextField('Enter title', titleController,
                  //     'Title is needed', TextInputType.name),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         addAndEditMovieTitile('Release Date'),
                  //         Container(
                  //           width: 170,
                  //           decoration: const BoxDecoration(),
                  //           child: Column(
                  //             children: [
                  //               DateTextformField(
                  //                 dateFocusNode: dateFocusNode,
                  //                 dateController: dateController,
                  //               )
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         addAndEditMovieTitile('Language'),
                  //         DropdownFormField(
                  //             hintText: 'Select Language',
                  //             options: optionsLanguage,
                  //             selectedGenre: selectedLanguage ?? '',
                  //             onGenreChanged: (value) {
                  //               setState(() {
                  //                 selectedLanguage = value;
                  //               });
                  //             })
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         addAndEditMovieTitile('Runtime'),
                  //         addAndEditMovieTextField(
                  //             'Enter runtime',
                  //             timeController,
                  //             'runtime is needed',
                  //             TextInputType.number)
                  //       ],
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         addAndEditMovieTitile('Director'),
                  //         addAndEditMovieTextField(
                  //             'Enter director',
                  //             directorController,
                  //             'director is needed',
                  //             TextInputType.name)
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         addAndEditMovieTitile('Rating'),
                  //         RatingBar.builder(
                  //           unratedColor: Colors.grey,
                  //           initialRating: movieRating,
                  //           direction: Axis.horizontal,
                  //           allowHalfRating: true,
                  //           itemCount: 5,
                  //           itemSize: 20,
                  //           itemBuilder: (context, _) => const Icon(
                  //             Icons.star,
                  //             color: Colors.amber,
                  //           ),
                  //           onRatingUpdate: (rating) {
                  //             setState(() {
                  //               movieRating = rating;
                  //             });
                  //           },
                  //         )
                  //       ],
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         addAndEditMovieTitile('Genre'),
                  //         DropdownFormField(
                  //           hintText: 'Select Genre',
                  //           selectedGenre: selectedGenre ?? '',
                  //           onGenreChanged: (value) {
                  //             setState(() {
                  //               selectedGenre = value;
                  //             });
                  //           },
                  //           options: optionsGenre,
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // addAndEditMovieTitile('Review'),
                  // reviewTextformField(reviewcontroller),
                  // addAndEditMovieTitile('Add theater'),
                  // addTheaterTextField(
                  //     'Enter Theaters', theaterController, TextInputType.name),
                  // submitButton(() {
                  //   List<String> theaters = theaterController.text
                  //       .split(',')
                  //       .map((e) => e.trim())
                  //       .toList();
                  //   addmovie(
                  //     theaters,
                  //     _formKey,
                  //     _selectedImage,
                  //     context,
                  //     movieRating,
                  //     titleController,
                  //     dateController,
                  //     selectedLanguage,
                  //     timeController,
                  //     directorController,
                  //     selectedGenre,
                  //     reviewcontroller,
                  //     ratingcontroller,
                  //     setState,
                  //   );
                  // })
                ],
              ),
            )),
      ),
    );
  }
}
