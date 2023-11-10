import 'package:hive_flutter/adapters.dart';
import 'package:uni_downloader/domain/downoadedfiles.dart';
import 'package:uni_downloader/models/downloaded_model.dart';

class ManageDownloadList implements DownloadedFiles {
  ManageDownloadList._internal();

  static ManageDownloadList instance = ManageDownloadList._internal();

  factory ManageDownloadList() {
    return instance;
  }

  // List<DownnLoadedTile> downloadlist = [];

  @override
  Future<void> addtoDataBase(DownnLoadedTile obj) async {
    final box = Hive.box<DownnLoadedTile>('DOWNLOAD_BOX');

    if (box.isOpen) {
      await box.add(obj);
    } else {
      final box = await Hive.openBox('DOWNLOAD_BOX');
      box.add(obj);
    }
  }

  @override
  Future<List<DownnLoadedTile>> getDownLoadlist() async {
    final box = Hive.box<DownnLoadedTile>('DOWNLOAD_BOX');
    final getlist = box.values;

    return getlist.toList();
  }

  @override
  Future<List<DownnLoadedTile>> deleteAll() async {
    final openbox = Hive.box<DownnLoadedTile>('DOWNLOAD_BOX');
    await openbox.deleteAll(openbox.keys);
    final list = await getDownLoadlist();

    return list;
  }
}
