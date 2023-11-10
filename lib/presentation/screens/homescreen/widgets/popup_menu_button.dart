import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_downloader/application/downloaded_bloc/DownloadedList/downloaded_bloc.dart';

import 'package:uni_downloader/consts/const.dart';
import 'package:uni_downloader/presentation/screens/homescreen/widgets/textwidget.dart';

class PopupMenuButtonWidget extends StatelessWidget {
  final List<PopupMenuItem<int>> menulist;

  const PopupMenuButtonWidget({super.key, required this.menulist});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: mediacontainercolor,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      child: const Icon(
        Icons.more_vert,
        color: whitecolor,
      ),
      itemBuilder: (context) {
        return menulist;
      },
      onSelected: (value) {
        if (value == 0) {
          log('history');

          Navigator.of(context).pushNamed('DownloadPage');
        } else if (value == 1) {
          log('share');
        } else if (value == 2) {
          log('how to use');
        } else if (value == 3) {
          log('about');
        } else {
          log('deleteall');

          BlocProvider.of<DownloadedBloc>(context).add(DeleteAll());
        }
      },
    );
  }
}

PopupMenuItem<int> item(String name, int value) {
  return PopupMenuItem(
    value: value,
    child: TextWidget(
      text: name,
      color: blackcolor,
      weight: FontWeight.w500,
    ),
  );
}
