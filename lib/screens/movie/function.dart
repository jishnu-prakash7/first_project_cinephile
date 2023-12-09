//Add movie screen functions

// ignore_for_file: camel_case_types

import 'package:firstprojectcinephile/models/comment.dart';
import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/models/watchlist.dart';
import 'package:firstprojectcinephile/screens/admin/admin_module_screen.dart';
import 'package:firstprojectcinephile/widgets/db_function.dart';
import 'package:firstprojectcinephile/widgets/main_refactoring.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void addmovie(
    List<String>? theaters,
    formKey,
    selectedImage,
    context,
    movieRating,
    titleController,
    dateController,
    selectedLanguage,
    timeController,
    directorController,
    selectedGenre,
    reviewcontroller,
    setstatecallback) {
  final isValid = formKey.currentState?.validate();
  final key = DateTime.now().millisecondsSinceEpoch;
  if (isValid!) {
    if (selectedImage == null) {
      showSnackBar(context, 'You must select an Image', Colors.red);
      return;
    } else if (movieRating == 0) {
      showSnackBar(context, 'You must select Rating', Colors.red);
      return;
    } else {
      addMovieToDb(movies(
          theaters: theaters ?? [],
          title: titleController.text.trim(),
          releaseyear: DateFormat('dd-MM-yyyy').parse(dateController.text),
          movielanguage: selectedLanguage,
          time: int.parse(timeController.text.trim()),
          moviedirector: directorController.text.trim(),
          movierating: movieRating,
          moviegenre: selectedGenre,
          review: reviewcontroller.text.trim(),
          imageUrl: selectedImage!.path,
          moviekey: key.toString()));

      titleController.clear();
      dateController.clear();
      timeController.clear();
      directorController.clear();
      reviewcontroller.clear();

      setstatecallback(() {
        selectedImage = null;
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
        movieIndex: movieindex.toString(),
        userIndex: userindex,
        comment: commentController.text.trim(),
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

//Filtering function

class FilterMovie {
  List search(String value, String selectedCatagory, Box moviesBox) {
    value = value.toLowerCase();
    List searchMovie = [];
    if (value.isNotEmpty) {
      searchMovie = moviesBox.values
          .where((movie) =>
              movie.title.toLowerCase().contains(value) ||
              movie.releaseyear.toString().contains(value) ||
              movie.movierating.toString().contains(value))
          .toList();
    } else {
      searchMovie = selectedCatagory.isEmpty
          ? List.from(moviesBox.values)
          : moviesBox.values
              .where((movie) =>
                  movie.moviegenre.toLowerCase() ==
                      selectedCatagory.toLowerCase() ||
                  movie.movielanguage.toLowerCase() ==
                      selectedCatagory.toLowerCase())
              .toList();
    }
    return searchMovie;
  }
}

//Update movie in database

void updateMovie(
    formKey,
    selectedImage,
    List<String>? theaters,
    titleController,
    languageController,
    timeController,
    dateController,
    directorController,
    movieRating,
    selectedGenre,
    reviewcontroller,
    index,
    context,
    moviekey) {
  final isValid = formKey.currentState?.validate();
  if (isValid!) {
    if (selectedImage == null) {
      showSnackBar(context, 'You must select an Image', Colors.red);
    } else {
      final value = movies(
          theaters: theaters ?? [],
          title: titleController.text,
          releaseyear: DateFormat('dd-MM-yyyy').parse(dateController.text),
          movielanguage: languageController.text,
          time: int.parse(timeController.text),
          moviedirector: directorController.text,
          movierating: movieRating,
          moviegenre: selectedGenre!,
          review: reviewcontroller.text,
          imageUrl: selectedImage!.path,
          moviekey: moviekey);

      updateMovieInDb(value, index);

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const AdminModule();
      }));
      showSnackBar(context, 'Movie Edited Succesfully', Colors.teal);
    }
  }
}

//watchlist adding and removing

class watchlistButton extends StatefulWidget {
  final int userIndex;
  final int movieIndex;

  const watchlistButton(
      {super.key, required this.userIndex, required this.movieIndex});

  @override
  State<watchlistButton> createState() => _addAndRemoveWatchlistState();
}

class _addAndRemoveWatchlistState extends State<watchlistButton> {
  late Box watchlistBox;
  @override
  void initState() {
    watchlistBox = Hive.box('watchlist');
    super.initState();
  }

  void watchlistButtonClick() {
    int watchlistMovieIndex = -1;

    for (int i = 0; i < watchlistBox.length; i++) {
      final item = watchlistBox.getAt(i) as Watchlist;
      if (item.userindex == widget.userIndex &&
          item.movieindex == widget.movieIndex) {
        watchlistMovieIndex = i;
        break;
      }
    }

    setState(() {
      if (watchlistMovieIndex != -1) {
        deleteFromWatchlist(watchlistMovieIndex);
        watchlistSnackBar(context, Colors.red, 'Movie Removed from Watchlist');
      } else {
        addToWatchlist(Watchlist(
            userindex: widget.userIndex, movieindex: widget.movieIndex));
        watchlistSnackBar(context, Colors.teal, 'Movie Added to Watchlist');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          watchlistButtonClick();
        },
        icon: Icon(
          watchlistBox.values.any((item) =>
                  item.userindex == widget.userIndex &&
                  item.movieindex == widget.movieIndex)
              ? Icons.bookmark
              : Icons.bookmark_border,
          color: Colors.white,
        ));
  }
}
