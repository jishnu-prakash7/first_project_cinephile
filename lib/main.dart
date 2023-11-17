// ignore_for_file: prefer_const_constructors, constant_identifier_names, unnecessary_import

import 'package:firstprojectcinephile/models/movies.dart';
import 'package:firstprojectcinephile/models/user.dart';
import 'package:firstprojectcinephile/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CinephileApp',
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
