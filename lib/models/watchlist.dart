import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'watchlist.g.dart';

@HiveType(typeId: 4)
class Watchlist extends HiveObject {
  @HiveField(0)
  final int userindex;

  @HiveField(1)
  final int movieindex;

  Watchlist({required this.userindex, required this.movieindex});
}
