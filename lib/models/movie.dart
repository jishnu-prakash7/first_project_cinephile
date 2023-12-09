// ignore_for_file: camel_case_types

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 1)
class movies extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final DateTime releaseyear;
  @HiveField(2)
  final String movielanguage;
  @HiveField(3)
  final int time;
  @HiveField(4)
  final String moviedirector;
  @HiveField(5)
  final double movierating;
  @HiveField(6)
  final String moviegenre;
  @HiveField(7)
  final String review;
  @HiveField(8)
  final String imageUrl;
  @HiveField(9)
  final List<String>? theaters;
  @HiveField(10)
  final String moviekey;

  movies(
      {this.theaters,
      required this.title,
      required this.releaseyear,
      required this.movielanguage,
      required this.time,
      required this.moviedirector,
      required this.movierating,
      required this.moviegenre,
      required this.review,
      required this.imageUrl,
      required this.moviekey});
}
