// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchlistAdapter extends TypeAdapter<Watchlist> {
  @override
  final int typeId = 4;

  @override
  Watchlist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Watchlist(
      userindex: fields[0] as int,
      movieindex: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Watchlist obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userindex)
      ..writeByte(1)
      ..write(obj.movieindex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchlistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
