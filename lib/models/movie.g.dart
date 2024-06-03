// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

part of 'movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class moviesAdapter extends TypeAdapter<movies> {
  @override
  final int typeId = 1;

  @override
  movies read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return movies(
      theaters: (fields[9] as List?)?.cast<String>(),
      title: fields[0] as String,
      releaseyear: fields[1] as DateTime,
      movielanguage: fields[2] as String,
      time: fields[3] as int,
      moviedirector: fields[4] as String,
      movierating: fields[5] as double,
      moviegenre: fields[6] as String,
      review: fields[7] as String,
      imageUrl: fields[8] as String,
      moviekey: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, movies obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.releaseyear)
      ..writeByte(2)
      ..write(obj.movielanguage)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.moviedirector)
      ..writeByte(5)
      ..write(obj.movierating)
      ..writeByte(6)
      ..write(obj.moviegenre)
      ..writeByte(7)
      ..write(obj.review)
      ..writeByte(8)
      ..write(obj.imageUrl)
      ..writeByte(9)
      ..write(obj.theaters)
      ..writeByte(10)
      ..write(obj.moviekey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is moviesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
