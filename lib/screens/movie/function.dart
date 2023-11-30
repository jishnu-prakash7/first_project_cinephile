//Add movie screen functions

import 'package:firstprojectcinephile/models/comment.dart';
import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/screens/admin/admin_module_screen.dart';
import 'package:firstprojectcinephile/widgets/db_function.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void addmovie(
    _formKey,
    _selectedImage,
    context,
    movieRating,
    titleController,
    dateController,
    languageController,
    timeController,
    directorController,
    genreController,
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

      setstatecallback(() {
        _selectedImage = null;
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
