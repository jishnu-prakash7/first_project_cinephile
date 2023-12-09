// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:firstprojectcinephile/screens/movie/function.dart';
import 'package:firstprojectcinephile/widgets/add_and_edit_movie_ref.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';

class addmovieSection extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final TextEditingController directorController;
  final TextEditingController reviewcontroller;
  final TextEditingController theaterController;
  final Key formKey;
  const addmovieSection(
      {super.key,
      required this.titleController,
      required this.dateController,
      required this.timeController,
      required this.directorController,
      required this.reviewcontroller,
      required this.theaterController,
      required this.formKey});

  @override
  State<addmovieSection> createState() => _addmovieSectionState();
}

class _addmovieSectionState extends State<addmovieSection> {
  List<String> optionsGenre = ['Action', 'Comedy', 'Horror', 'Fiction'];
  List<String> optionsLanguage = ['English', 'Hindi', 'Malayalam', 'Tamil'];
  String? selectedGenre;
  String? selectedLanguage;
  final dateFocusNode = FocusNode();
  XFile? _selectedImage;
  double movieRating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                XFile? pickimage = await pickImageFormgallery();
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
                  : const Icon(Icons.add_a_photo, color: Colors.white),
            )),
        addAndEditMovieTitile('Movie Title'),
        addAndEditMovieTextField('Enter title', widget.titleController,
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
                  decoration: const BoxDecoration(),
                  child: Column(
                    children: [
                      DateTextformField(
                        dateFocusNode: dateFocusNode,
                        dateController: widget.dateController,
                      )
                    ],
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addAndEditMovieTitile('Language'),
                DropdownFormField(
                    hintText: 'Select Language',
                    options: optionsLanguage,
                    selectedGenre: selectedLanguage ?? '',
                    onGenreChanged: (value) {
                      setState(() {
                        selectedLanguage = value;
                      });
                    })
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
                addAndEditMovieTextField('Enter runtime', widget.timeController,
                    'runtime is needed', TextInputType.number)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addAndEditMovieTitile('Director'),
                addAndEditMovieTextField(
                    'Enter director',
                    widget.directorController,
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
                  itemBuilder: (context, _) => const Icon(
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
                DropdownFormField(
                  hintText: 'Select Genre',
                  selectedGenre: selectedGenre ?? '',
                  onGenreChanged: (value) {
                    setState(() {
                      selectedGenre = value;
                    });
                  },
                  options: optionsGenre,
                ),
              ],
            ),
          ],
        ),
        addAndEditMovieTitile('Review'),
        reviewTextformField(widget.reviewcontroller),
        addAndEditMovieTitile('Add theater'),
        addTheaterTextField(
            'Enter Theaters', widget.theaterController, TextInputType.name),
            if(isValidRuntime())
        submitButton(() {
          List<String> theaters = widget.theaterController.text
              .split(',')
              .map((e) => e.trim())
              .toList();
          addmovie(
            theaters,
            widget.formKey,
            _selectedImage,
            context,
            movieRating,
            widget.titleController,
            widget.dateController,
            selectedLanguage,
            widget.timeController,
            widget.directorController,
            selectedGenre,
            widget.reviewcontroller,
            setState,
          );
        })
      ],
    );
  }
  bool isValidRuntime() {
  // Check if the runtime is greater than zero
  final int runtime = int.tryParse(widget.timeController.text) ?? 0;
  return runtime > 0;
}
}
