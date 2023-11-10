import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_downloader/application/convertbloc/getvedio/convert_bloc.dart';

import 'package:uni_downloader/consts/const.dart';

import 'package:uni_downloader/presentation/screens/homescreen/widgets/buttons.dart';
import 'package:uni_downloader/presentation/screens/homescreen/widgets/showmessageclass.dart';

import 'package:uni_downloader/presentation/screens/homescreen/widgets/textwidget.dart';
import 'package:uni_downloader/presentation/screens/homescreen/widgets/urlpasterowfield.dart';

class MediaContainer extends StatelessWidget {
  final double width;
  final double? height;
  final double thumbnaiwidth;
  final double thumbnaiheight;
  final Color? color;
  final double? allpadding;
  final bool? isvisible;
  final String title;
  final num? totalsize;
  final String image;
  final Duration duration;
  const MediaContainer({
    super.key,
    required this.width,
    this.height,
    required this.thumbnaiwidth,
    required this.thumbnaiheight,
    this.allpadding,
    this.color,
    this.isvisible,
    this.totalsize,
    required this.title,
    required this.image,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double setwidth = size.width / 2;

    return Padding(
      padding: EdgeInsets.all(allpadding ?? 0.0),
      child: Visibility(
        visible: isvisible ?? false,
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Container(
                width: thumbnaiwidth,
                height: thumbnaiheight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: color,
                    image: DecorationImage(
                        image: NetworkImage(image),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                        onError: (exception, stackTrace) {
                          print('mediacontainer onerror called $exception');
                          const Center(child: Icon(Icons.image));
                        })),
              ),
              height20,
              Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: size.width,
                  // color: Colors.white,
                  child: TextWidget(
                    text: title,
                    overflow: TextOverflow.fade,
                    weight: FontWeight.bold,
                    aligntext: TextAlign.left,
                  )),
              height20,
              Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: size.width,
                  child: TextWidget(
                    text: duration.toString().split('.').first,
                    weight: FontWeight.bold,
                    aligntext: TextAlign.left,
                  )),
              height20,
              BlocBuilder<ConvertBloc, ConvertState>(builder: (context, state) {
                if (state.ischecking == true) {
                  return const ShowLoadingIndicator(
                    loadingmessage: 'Analyzing......',
                  );
                }

                if (state.isckeckingcomplited == false) {
                  return InkWell(
                    onTap: () {
                      context.read<ConvertBloc>().add(AnalyzingData());
                    },
                    child: ButtonWidget(
                        width: size.width - 100,
                        height: 40,
                        radius: 10,
                        color: greencolor,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: ' Analyze ',
                              weight: FontWeight.bold,
                              color: whitecolor,
                            ),
                            Icon(
                              Icons.rotate_left_rounded,
                              color: whitecolor,
                            )
                          ],
                        )),
                  );
                } else {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          BlocProvider.of<ConvertBloc>(context).add(DownloadMp3(
                            context: context,
                          ));
                        },
                        child: ButtonWidget(
                            width: size.width - 100,
                            height: 40,
                            radius: 10,
                            color: greencolor,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                  text: 'Download MP3 ',
                                  weight: FontWeight.bold,
                                  color: whitecolor,
                                ),
                                Icon(
                                  Icons.download,
                                  color: whitecolor,
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: setwidth / 1.5,
                            right: setwidth / 1.5,
                            top: 10,
                            bottom: 10),
                        child: const Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<ConvertBloc>(context)
                              .add(DownLoadMp4(thirdurl: textcontroll.text));
                        },
                        child: ButtonWidget(
                            width: size.width - 100,
                            height: 40,
                            radius: 10,
                            color: greencolor,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                  text: 'Download MP4 ',
                                  weight: FontWeight.bold,
                                  color: whitecolor,
                                ),
                                Icon(
                                  Icons.download,
                                  color: whitecolor,
                                )
                              ],
                            )),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
