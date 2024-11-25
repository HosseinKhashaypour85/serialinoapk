// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavMovieAdapter extends TypeAdapter<FavMovie> {
  @override
  final int typeId = 0;

  @override
  FavMovie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavMovie(
      title: fields[0] as String,
      imagePath: fields[1] as String,
      releaseYear: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavMovie obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.releaseYear);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavMovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
