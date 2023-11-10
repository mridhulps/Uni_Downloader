// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloaded_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownnLoadedTileAdapter extends TypeAdapter<DownnLoadedTile> {
  @override
  final int typeId = 1;

  @override
  DownnLoadedTile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownnLoadedTile(
      title: fields[0] as String,
      author: fields[1] as String,
      image: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DownnLoadedTile obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownnLoadedTileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
