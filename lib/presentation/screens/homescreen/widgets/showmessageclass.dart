import 'package:flutter/material.dart';
import 'package:uni_downloader/infrastructure/receivemedia.dart';

import '../../../../consts/const.dart';
import 'textwidget.dart';

class ShowMessage extends StatelessWidget {
  final String message;
  final Color? messagecolor;
  const ShowMessage({super.key, required this.message, this.messagecolor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextWidget(
          text: message.toString(),
          weight: FontWeight.bold,
          color: messagecolor ?? Colors.black,
        ),
        height20,
        MaterialButton(
          color: greencolor.shade400,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide.none),
          elevation: 5,
          onPressed: () {
            manageurl(context, '');
          },
          child: const TextWidget(
            text: 'Retry',
            color: whitecolor,
          ),
        )
      ]),
    );
  }
}

class ShowLoadingIndicator extends StatelessWidget {
  final String loadingmessage;
  const ShowLoadingIndicator({super.key, required this.loadingmessage});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          color: greencolor,
          strokeWidth: 5,
        ),
        height20,
        TextWidget(
          text: loadingmessage.toString(),
          size: 17,
          weight: FontWeight.w500,
        )
      ],
    ));
  }
}
