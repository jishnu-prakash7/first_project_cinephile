import 'dart:io';

import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/screens/movie/function.dart';
import 'package:firstprojectcinephile/widgets/add_and_edit_movie_ref.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

class editMovieSection extends StatefulWidget {
  final movies movie;
  final int index;
  final TextEditingController titleController;
  final TextEditingController timeController;
  final TextEditingController languageController;
  final TextEditingController dateController;
  final TextEditingController directorController;
  final TextEditingController genreController;
  final TextEditingController reviewcontroller;
  final TextEditingController theaterController;
  final Key formkey;
  const editMovieSection({
    super.key,
    required this.movie,
    required this.titleController,
    required this.timeController,
    required this.languageController,
    required this.directorController,
    required this.genreController,
    required this.reviewcontroller,
    required this.theaterController,
    required this.formkey,
    required this.index,
    required this.dateController,
  });

  @override
  State<editMovieSection> createState() => _editMovieSectionState();
}

class _editMovieSectionState extends State<editMovieSection> {
  XFile? _selectedImage;
  double movieRating = 0.0;
  final dateFocusNode = FocusNode();
  List<String> optionsGenre = ['Action', 'Comedy', 'Horror', 'Fiction'];
  List<String> optionsLanguage = ['English', 'Hindi', 'Malayalam', 'Tamil'];
  String? selectedGenre;
  String? selectedLanguage;
  List<String>? theaters;
  @override
  void initState() {
    movieRating = widget.movie.movierating;
    _selectedImage = XFile(widget.movie.imageUrl);
    selectedGenre = widget.movie.moviegenre;
    selectedLanguage = widget.movie.movielanguage;
    super.initState();
  }

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
              border: Border.all(width: .7, color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
                onTap: () async {
                  XFile? pickimage = await pickImageFormgallery();
                  setState(() {
                    _selectedImage = pickimage;
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(_selectedImage!.path),
                    fit: BoxFit.cover,
                  ),
                )
                // : ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: Image.file(
                //       File(widget.movie.imageUrl),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
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
                          dateController: widget.dateController)
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
                    initialvalue: widget.movie.movielanguage,
                    selectedGenre: selectedLanguage ?? '',
                    onGenreChanged: (value) {
                      selectedLanguage = value;
                    },
                    options: optionsLanguage,
                    hintText: 'Enter Language')
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
                  initialRating: widget.movie.movierating,
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
                    initialvalue: widget.movie.moviegenre,
                    selectedGenre: selectedGenre ?? '',
                    onGenreChanged: (value) {
                      selectedGenre = value;
                    },
                    options: optionsGenre,
                    hintText: 'Enter Genre')
              ],
            ),
          ],
        ),
        addAndEditMovieTitile('Add theater'),
        addTheaterTextField(
            'Enter Theaters', widget.theaterController, TextInputType.name),
        addAndEditMovieTitile('Review'),
        reviewTextformField(widget.reviewcontroller),
        submitButton(() {
          theaters = widget.theaterController.text
              .split(',')
              .map((e) => e.trim())
              .toList();
          updateMovie(
              widget.formkey,
              _selectedImage,
              theaters,
              widget.titleController,
              widget.languageController,
              widget.timeController,
              widget.dateController,
              widget.directorController,
              movieRating,
              selectedGenre,
              widget.reviewcontroller,
              widget.index,
              context,
              widget.movie.moviekey);
        })
      ],
    );
  }
}
