import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/screens/admin/admin_module_screen.dart';
import 'package:firstprojectcinephile/screens/movie/movie_edit_screen/widgets.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  late TextEditingController theaterController;
  List<String>? theaters;

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
    dateController = TextEditingController(
        text: DateFormat('dd-MM-yyyy').format(widget.movie.releaseyear));
    super.initState();
    movieRating = widget.movie.movierating;
    selectedGenre = widget.movie.moviegenre;
    selectedLanguage = widget.movie.movielanguage;
    theaterController =
        TextEditingController(text: widget.movie.theaters?.join(','));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          elevation: 0,
          backgroundColor: Colors.black,
          title: appbarHeading('Edit Movie', 25)),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  editMovieSection(
                    movie: widget.movie,
                    titleController: titleController,
                    timeController: timeController,
                    languageController: languageController,
                    directorController: directorController,
                    genreController: genreController,
                    reviewcontroller: reviewcontroller,
                    theaterController: theaterController,
                    formkey: _formKey,
                    index: widget.index,
                    dateController: dateController,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
