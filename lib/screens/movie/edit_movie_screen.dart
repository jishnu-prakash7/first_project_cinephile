import 'dart:io';

import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/screens/admin/admin_module_screen.dart';
import 'package:firstprojectcinephile/widgets/add_and_edit_movie_ref.dart';
import 'package:firstprojectcinephile/widgets/db_function.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditAndDeleteScreen extends StatefulWidget {
  final movies movie;
  final int index;
  const EditAndDeleteScreen(
      {super.key, required this.movie, required this.index});

  @override
  State<EditAndDeleteScreen> createState() => _EditAndDeleteScreenState();
}

class _EditAndDeleteScreenState extends State<EditAndDeleteScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController languageController;
  late TextEditingController timeController;
  late TextEditingController directorController;
  late TextEditingController genreController;
  late TextEditingController reviewcontroller;

  XFile? _selectedImage;
  double movieRating = 0.0;
  late TextEditingController dateController;
  final dateFocusNode = FocusNode();
  List<String> optionsGenre = ['Action', 'Comedy', 'Horror', 'Fiction'];
  List<String> optionsLanguage = ['English', 'Hindi', 'Malayalam', 'Tamil'];
  String? selectedGenre;
  String? selectedLanguage;
  late Box moviesBox;

  @override
  void initState() {
    moviesBox = Hive.box('movies');
    titleController = TextEditingController(text: widget.movie.title);
    languageController =
        TextEditingController(text: widget.movie.movielanguage);
    timeController = TextEditingController(text: widget.movie.time.toString());
    directorController =
        TextEditingController(text: widget.movie.moviedirector);
    genreController = TextEditingController(text: widget.movie.moviegenre);
    reviewcontroller = TextEditingController(text: widget.movie.review);
    _selectedImage = XFile(widget.movie.imageUrl);
    dateController = TextEditingController(
        text: DateFormat('dd-MM-yyyy').format(widget.movie.releaseyear));
    super.initState();
    movieRating = widget.movie.movierating;
    selectedGenre = widget.movie.moviegenre;
    selectedLanguage = widget.movie.movielanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return const AdminModule();
                }));
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: appbarHeading('Edit Movie', 25)),
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
                        child: _selectedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(_selectedImage!.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(widget.movie.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                            decoration: const BoxDecoration(),
                            child: Column(
                              children: [
                                DateTextformField(
                                    dateFocusNode: dateFocusNode,
                                    dateController: dateController)
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
                          // addAndEditMovieTextField(
                          //     'Enter language',
                          //     languageController,
                          //     'language is needed',
                          //     TextInputType.name)
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
                          // addAndEditMovieTextField(
                          //     'eg:Action,Comedy',
                          //     genreController,
                          //     'genre is needed',
                          //     TextInputType.name)
                        ],
                      ),
                    ],
                  ),
                  addAndEditMovieTitile('Review'),
                  reviewTextformField(reviewcontroller),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: const Size(150, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {
                              updateMovie();
                            },
                            child: Text(
                              'Submit',
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
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

  void updateMovie() {
    final isValid = _formKey.currentState?.validate();
    if (isValid!) {
      if (_selectedImage == null) {
        showSnackBar(context, 'You must select an Image', Colors.red);
      } else {
        final value = movies(
            title: titleController.text,
            releaseyear: DateFormat('dd-MM-yyyy').parse(dateController.text),
            movielanguage: languageController.text,
            time: int.parse(timeController.text),
            moviedirector: directorController.text,
            movierating: movieRating,
            moviegenre: selectedGenre!,
            review: reviewcontroller.text,
            imageUrl: _selectedImage!.path);

        updateMovieInDb(value, widget.index);

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const AdminModule();
        }));
        showSnackBar(context, 'Movie Edited Succesfully', Colors.teal);
      }
    }
  }
}
