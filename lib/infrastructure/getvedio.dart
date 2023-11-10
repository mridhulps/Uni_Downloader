// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:permission_handler/permission_handler.dart';

class GetvedioInformation {
  GetvedioInformation.internal();
  static GetvedioInformation instance = GetvedioInformation.internal();

  factory GetvedioInformation() {
    return instance;
  }

  YoutubeExplode youtubeexplode = YoutubeExplode();

  String urlvalue = '';

  String currenttitle = '';

  Future<Map<String, dynamic>> getvedioinfo(String url) async {
    final vedio = await youtubeexplode.videos.get(url.toString());

    final manifest =
        await youtubeexplode.videos.streamsClient.getManifest(vedio.id);

    final audio =
        manifest.audioOnly.withHighestBitrate().bitrate.megaBitsPerSecond;

    final thumbnail = vedio.thumbnails.highResUrl;

    urlvalue = url;

    currenttitle = vedio.title;

    return {
      'Title': vedio.title,
      'Author': vedio.author,
      'Duration': vedio.duration,
      'Thumbnail': thumbnail,
      'Mp3size': audio
    };
  }

  Future<bool> downloadaudiomp3(
    String savepath,
  ) async {
    final permissiongranded = await requistpermission(Permission.storage);

    bool status = false;

    if (permissiongranded == false) {
      await openAppSettings();
    } else {
      final audiostream = await getAudioStream();

      final file = File("$savepath/YD-$currenttitle.mp3");

      final stat = await downloadAudioorVedio(file, audiostream);

      status = stat;
    }
    return status;
  }

  //DOWNLOAS MP4 HERE;

  Future<bool> downloadmp4(String savepath) async {
    final permissiongranded = await requistpermission(Permission.storage);

    if (permissiongranded == false) {
      await openAppSettings();
    }

    final vediostream = await getVedioStream();

    final file = File('$savepath/YD-$currenttitle.mp4');

    final status = await downloadAudioorVedio(file, vediostream);

    return status;
  }

  //DOWNLAOD MP4 SUPPORTERS;

  Future<bool> downloadAudioorVedio(File file, Stream<List<int>> bytes) async {
    final stream = file.openWrite(mode: FileMode.write);

    bool status = false;

    await for (var data in bytes) {
      stream.add(data);
    }
    return status = true;
  }

  Future<Stream<List<int>>> getAudioStream() async {
    final YoutubeExplode youtubeexplode = YoutubeExplode();

    final vedio = await youtubeexplode.videos.get(urlvalue.toString());

    final manifest =
        await youtubeexplode.videos.streamsClient.getManifest(vedio.id);

    final vediost = manifest.audioOnly.withHighestBitrate();

    final audiostream = youtubeexplode.videos.streamsClient.get(vediost);

    return audiostream;
  }

  Future<Stream<List<int>>> getVedioStream() async {
    final YoutubeExplode youtubeexplode = YoutubeExplode();

    final vedio = await youtubeexplode.videos.get(urlvalue.toString());

    final manifest =
        await youtubeexplode.videos.streamsClient.getManifest(vedio.id);

    final vediost = manifest.muxed.withHighestBitrate();

    final vediostream = youtubeexplode.videos.streamsClient.get(vediost);

    return vediostream;
  }
}

// USING FUNCTIONS;

//PERMISSION METHODE;

Future<bool> requistpermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    final status = await permission.request();

    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}

//CREATE APP DIRECTORY NOT EXIST IF ALREADY EXIST RETURN PATH FUNCTION

Future<Directory> createdirectory() async {
  final dir = await getExternalStorageDirectory();

  if (dir == null) {}

  final path = Directory(dir!.path);

  if (await path.exists()) {
    return path;
  } else {
    final dir = await path.create();
    return dir;
  }
}

// APP DIRECTORY GET ALL FILES AND RETURN LIST<FILES> FUNCTION

Future<List<String>> directoryFileList() async {
  final directory = await createdirectory();

  final List<String> directoryFileList = [];

  final filelist = directory.listSync(recursive: true).toList();

  Future.forEach(filelist, (element) {
    final fileName = element.uri.pathSegments.last;

    directoryFileList.add(fileName);
  });

  return directoryFileList;
}

// DOWNLOAD DIRECTORY FUNCTIONS ;

// GET DOWNLOAD DIRECTORY

Future<String> getDownLoadDirectory() async {
  final dirctory = Directory('/storage/emulated/0/');

  final filelist = dirctory.listSync().toList();

  String path = '';

  for (FileSystemEntity file in filelist) {
    final folder = file.toString().split('/').toList().last;

    if (folder == "Download'") {
      final dirpath = Directory('/storage/emulated/0/Download');

      path = dirpath.path;

      break;
    } else {
      path = '';
    }
  }

  return path;
}

// CHECK FILES ALREADY EXIST IN DOWNLOAD DIRCTORY IF EXIST RETURN BOOL FUNCTION.

Future<bool> isExistInDownloadDirectory(
    Directory directory, currenttitle) async {
  bool status = false;

  try {
    final dir = directory;

    final dlist = dir.listSync().toList();

    for (FileSystemEntity file in dlist) {
      final filename = file.uri.pathSegments.last;

      if (filename == currenttitle) {
        status = true;
        break;
      }
    }

    return status;
  } catch (e) {
    log('downlaod directory exception cached =$e');
    return status = false;
  }
}
