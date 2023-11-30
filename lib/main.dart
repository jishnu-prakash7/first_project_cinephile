// ignore_for_file: constant_identifier_names

import 'package:firstprojectcinephile/models/comment.dart';
import 'package:firstprojectcinephile/models/movie.dart';
import 'package:firstprojectcinephile/models/user.dart';
import 'package:firstprojectcinephile/models/watchlist.dart';
import 'package:firstprojectcinephile/screens/movie/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path;

const KEY = "UserLoggedIn";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.initFlutter('hive_db');

  Hive.registerAdapter(moviesAdapter());
  await Hive.openBox('movies');
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox('user');
  Hive.registerAdapter(CommentAdapter());
  await Hive.openBox('comment');
  Hive.registerAdapter(WatchlistAdapter());
  await Hive.openBox('watchlist');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CinephileApp',
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
