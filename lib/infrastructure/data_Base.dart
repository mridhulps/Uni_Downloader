// ignore: file_names
import 'package:hive_flutter/adapters.dart';
import 'package:uni_downloader/models/downloaded_model.dart';

//DATA REGISTER ADAPTER FUNCTON;

Future<void> registerAdatpter() async {
  if (!Hive.isAdapterRegistered(DownnLoadedTileAdapter().typeId)) {
    Hive.registerAdapter(DownnLoadedTileAdapter());
  } else {
    return;
  }
}
