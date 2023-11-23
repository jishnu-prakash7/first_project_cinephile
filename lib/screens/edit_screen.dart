import 'dart:io';

import 'package:firstprojectcinephile/models/movies.dart';
import 'package:firstprojectcinephile/screens/admin_module.dart';
import 'package:firstprojectcinephile/widgets/add_and_edit_movie.dart';
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
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return const AdminModule();
              }));
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title:appbarHeading('Edit Movie',25)
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
                        border: Border.all(width: .7, color: Colors.grey),
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
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                  decoration: InputDecoration(
                                      fillColor:
                                          const Color.fromARGB(255, 39, 38, 38),
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.only(left: 20),
                                      hintText: 'Select Date',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 2)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
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
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: const Color.fromARGB(255, 39, 38, 38),
                        filled: true,
                        hintText: 'Write review...',
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
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
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('you must select an Image')));
      } else {
        final value = movies(
            title: titleController.text,
            releaseyear: DateFormat('dd-MM-yyyy').parse(dateController.text),
            movielanguage: languageController.text,
            time: int.parse(timeController.text),
            moviedirector: directorController.text,
            movierating: movieRating,
            moviegenre: genreController.text,
            review: reviewcontroller.text,
            imageUrl: _selectedImage!.path);

        moviesBox.putAt(widget.index, value);

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const AdminModule();
        }));
        showSnackBar(context, 'Movie Edited Succesfully', Colors.teal);
      }
    }
  }
}
