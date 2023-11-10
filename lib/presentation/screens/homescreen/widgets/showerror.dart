import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:uni_downloader/presentation/screens/homescreen/widgets/textwidget.dart';

class ShowAnimation extends StatelessWidget {
  final String error;
  final Color? color;
  final String animationurl;
  const ShowAnimation(
      {super.key, required this.error, this.color, required this.animationurl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Lottie.asset(
          animationurl,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
                child: TextWidget(
              text: 'SOMETHING WENT WRONG...',
              weight: FontWeight.bold,
            ));
          },
        ),
        TextWidget(
          text: error,
          color: color,
          weight: FontWeight.bold,
          size: 16,
        ),
      ]),
    );
  }
}

class ShowDownloadComplited extends StatelessWidget {
  final String message;
  final Color? color;
  final String animationurl;
  const ShowDownloadComplited(
      {super.key,
      required this.message,
      this.color,
      required this.animationurl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Lottie.asset(
          animationurl,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
                child: TextWidget(
              text: 'SOMETHING WENT WRONG...',
              weight: FontWeight.bold,
            ));
          },
          fit: BoxFit.contain,
          width: size.width / 1.6,
        ),
        TextWidget(
          text: message,
          color: color,
          weight: FontWeight.bold,
          size: 16,
        ),
      ]),
    );
  }
}
