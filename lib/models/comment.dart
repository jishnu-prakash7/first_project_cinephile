import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
part 'comment.g.dart';

@HiveType(typeId: 3)
class Comment extends HiveObject {
  @HiveField(0)
  final String movieIndex;
  @HiveField(1)
  final int userIndex;
  @HiveField(2)
  final String comment;
  @HiveField(3)
  final DateTime date;

  Comment(
      {required this.movieIndex,
      required this.userIndex,
      required this.comment,
      required this.date});
}
