import 'package:hive_flutter/adapters.dart';

part 'downloaded_model.g.dart';

@HiveType(typeId: 1)
class DownnLoadedTile {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String author;
  // @HiveField(2)
  // final Duration duration;
  @HiveField(3)
  final String image;

  DownnLoadedTile(
      {required this.title,
      required this.author,
     // required this.duration,
      required this.image});
}
