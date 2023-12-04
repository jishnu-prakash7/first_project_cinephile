//Add movie screen functions

import 'package:firstprojectcinephile/models/comment.dart';
import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/screens/admin/admin_module_screen.dart';
import 'package:firstprojectcinephile/widgets/db_function.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void addmovie(
    _formKey,
    _selectedImage,
    context,
    movieRating,
    titleController,
    dateController,
    selectedLanguage,
    timeController,
    directorController,
    selectedGenre,
    reviewcontroller,
    ratingcontroller,
    setstatecallback) {
  final isValid = _formKey.currentState?.validate();
  if (isValid!) {
    if (_selectedImage == null) {
      showSnackBar(context, 'You must select an Image', Colors.red);
      return;
    } else if (movieRating == 0) {
      showSnackBar(context, 'You must select Rating', Colors.red);
      return;
    } else {
      addMovieToDb(movies(
          title: titleController.text.trim(),
          releaseyear: DateFormat('dd-MM-yyyy').parse(dateController.text),
          movielanguage: selectedLanguage,
          time: int.parse(timeController.text.trim()),
          moviedirector: directorController.text.trim(),
          movierating: movieRating,
          moviegenre: selectedGenre,
          review: reviewcontroller.text.trim(),
          imageUrl: _selectedImage!.path));

      titleController.clear();
      dateController.clear();
      timeController.clear();
      directorController.clear();
      ratingcontroller.clear();
      reviewcontroller.clear();

      setstatecallback(() {
        _selectedImage = null;
        selectedGenre = null;
        selectedLanguage = null;
      });

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return const AdminModule();
      }), (route) => false);
      showSnackBar(context, 'Movie Added Succesfully', Colors.teal);
    }
  }
}

//get user index

Future<int?> getUserIndex() async {
  final sharedprefs = await SharedPreferences.getInstance();
  final loggedInUserIndex = sharedprefs.getInt('loggedInUserIndexKey');
  return loggedInUserIndex;
}

//Add comment

void addcomment(formkey, movieindex, userindex, commentController) {
  final isvalid = formkey.currentState?.validate();
  if (isvalid!) {
    addcommentToDb(Comment(
        movieIndex: movieindex,
        userIndex: userindex,
        comment: commentController.text,
        date: DateTime.now()));
    commentController.clear();
  }
}

//Watchlist snackbar

void watchlistSnackBar(
    BuildContext context, Color backgroundColor, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 1),
    margin: const EdgeInsets.all(80),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

//Filtering functions

void search(
    {TextEditingController? searchController,
    searchMovie,
    Box? moviesBox,
    selectedCatagory}) {
  String query = searchController!.text.toLowerCase();
  if (query.isNotEmpty) {
    searchMovie = moviesBox!.values
        .where((movie) =>
            movie.title.toLowerCase().contains(query) ||
            movie.releaseyear.toString().contains(query) ||
            movie.movierating.toString().contains(query))
        .toList();
  } else {
    searchMovie = selectedCatagory.isEmpty
        ? List.from(moviesBox!.values)
        : moviesBox!.values
            .where((movie) =>
                movie.moviegenre.toLowerCase() ==
                    selectedCatagory.toLowerCase() ||
                movie.movielanguage.toLowerCase() ==
                    selectedCatagory.toLowerCase())
            .toList();
  }
}
