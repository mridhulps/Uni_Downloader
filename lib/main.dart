import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_downloader/app_lifecycle_manager/app_lifecyble_manager.dart';
import 'package:uni_downloader/application/convertbloc/getvedio/convert_bloc.dart';
import 'package:uni_downloader/application/downloaded_bloc/DownloadedList/downloaded_bloc.dart';

import 'package:uni_downloader/models/downloaded_model.dart';
import 'package:uni_downloader/presentation/screens/download_screen/downloaded_screen.dart';

import 'package:uni_downloader/presentation/screens/homescreen/homesscreen.dart';

import 'infrastructure/data_Base.dart';

late SharedPreferences sharedpref;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await registerAdatpter();

  await Hive.openBox<DownnLoadedTile>('DOWNLOAD_BOX');

  sharedpref = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConvertBloc(),
        ),
        BlocProvider(
          create: (context) => DownloadedBloc(),
        )
      ],
      child: AppLifecycleManager(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          ),
          home: const HomeScreen(),
          routes: {
            'DownloadPage': (context) => const DownLoadPage(),
          },
        ),
      ),
    );
  }
}
