import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uni_downloader/infrastructure/getvedio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Development extends StatefulWidget {
  const Development({Key? key}) : super(key: key);

  @override
  DevelopmentState createState() => DevelopmentState();
}

class DevelopmentState extends State<Development> {
  String path = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('data'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final path = await tesingdirectory();
        log(path);
      }),
    );
  }
}

Future<String> tesingdirectory() async {
  final dirctory = Directory('/storage/emulated/0/');

  final filelist = dirctory.listSync().toList();

  String path = '';

  for (FileSystemEntity file in filelist) {
    final folder = file.toString().split('/').toList().last;

    print(folder);

    if (folder == "Download'") {
      final dirpath = Directory('/storage/emulated/0/Download');
      path = dirpath.path;
      print('fild existeddddd');
      break;
    } else {
      print('file not is existed');
    }
  }

  return path;
}
