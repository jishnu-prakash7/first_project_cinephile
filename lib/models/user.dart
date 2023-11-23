import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User extends HiveObject {
  @HiveField(0)
  final String userName;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final int password;
  @HiveField(3)
  final String? image;

  User(
      {required this.userName,
      required this.email,
      required this.password,
      this.image});
}
