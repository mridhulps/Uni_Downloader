import 'package:uni_downloader/models/downloaded_model.dart';

abstract class DownloadedFiles {
  Future<void> addtoDataBase(DownnLoadedTile obj);

  Future<List<DownnLoadedTile>> getDownLoadlist();

  Future<List<DownnLoadedTile>> deleteAll();
}
