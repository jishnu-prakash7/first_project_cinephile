import 'package:firstprojectcinephile/models/comment.dart';
import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/models/user.dart';
import 'package:firstprojectcinephile/models/watchlist.dart';
import 'package:hive_flutter/hive_flutter.dart';

//Add new movie to database
addMovieToDb(movies movie) {
  Hive.box('movies').add(movie);
}

//Add new user to database
addUserToDb(User user) {
  Hive.box('user').add(user);
}

//Edit movie in database
updateMovieInDb(movies movie, int index) {
  Hive.box('movies').putAt(index, movie);
}

// Edit user in database
updateUserInDb(User user, int index) {
  Hive.box('user').putAt(index, user);
}

//Add new comment to database
addcommentToDb(Comment comment) {
  Hive.box('comment').add(comment);
}

//get movie from database
movies getMovieAt(int index) {
  Box moviesBox = Hive.box('movies');
  return moviesBox.getAt(index) as movies;
}

//get user from database
User getUserAt(int index) {
  Box userBox = Hive.box('user');
  return userBox.getAt(index) as User;
}

//Add to watchlist

addToWatchlist(Watchlist movie) {
  Hive.box('watchlist').add(movie);
}

//delete from watchlist

deleteFromWatchlist(int index) {
  Hive.box('watchlist').deleteAt(index);
}
