import 'package:flutter/material.dart';

import 'package:uni_downloader/consts/const.dart';

import 'package:uni_downloader/presentation/screens/homescreen/widgets/mediacontainer_builder.dart';
import 'package:uni_downloader/presentation/screens/homescreen/widgets/popup_menu_button.dart';

import 'package:uni_downloader/presentation/screens/homescreen/widgets/textwidget.dart';

import 'package:uni_downloader/presentation/screens/homescreen/widgets/urlpasterowfield.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: const TextWidget(
          text: 'Youtube To Mp3 ',
          size: 20,
          weight: FontWeight.bold,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: PopupMenuButtonWidget(menulist: [
                item('History', 0),
                item('Share', 1),
                item('Hown to use', 2),
                item('About', 3),
              ]))
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        width: size.width,
        height: size.height,
        child: Column(children: [
          const SizedBox(
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: TextWidget(
                  // text: 'Convert and Download Youtube Videos or MP3 '

                  text: '',
                  color: whitecolor,
                  size: 14,
                  weight: FontWeight.w400,
                ),
              ),
              height20,
              UrlPasteFieldRow()
            ]),
          ),

          //MEDIA SHOW CONTAINER;
          Container(
            margin: const EdgeInsets.only(top: 45),
            height: size.height / 1.5,
            width: size.width,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(29),
              color: Colors.grey.shade300,
            ),
            child: MediaBuilder(),
          ),
        ]),
      )),
    );
  }
}
