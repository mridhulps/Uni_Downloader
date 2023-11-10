import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uni_downloader/application/downloaded_bloc/DownloadedList/downloaded_bloc.dart';

import 'package:uni_downloader/consts/const.dart';
import 'package:uni_downloader/presentation/screens/download_screen/widgets/custom_appbar.dart';

import 'package:uni_downloader/presentation/screens/homescreen/widgets/textwidget.dart';

class DownLoadPage extends StatelessWidget {
  const DownLoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    BlocProvider.of<DownloadedBloc>(context).add(DownloadedList());

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.width / 6),
          child: const CustomAppbar()),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: BlocBuilder<DownloadedBloc, DownloadedState>(builder: (
          context,
          state,
        ) {
          if (state.isloading == true) {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation<Color>(whitecolor),
              ),
            );
          } else if (state.downloadinglist.isEmpty) {
            return const Center(
              child: TextWidget(
                text: 'NOTHING FOUND..',
                color: whitecolor,
              ),
            );
          } else {
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, index) {
                  final list = state.downloadinglist[index];

                  return ListTile(
                    iconColor: whitecolor,
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image(
                        image: NetworkImage(list.image),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_outlined);
                        },
                      ),
                    ),
                    title: TextWidget(
                      text: list.title,
                      color: whitecolor,
                      aligntext: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: TextWidget(
                      text: list.author,
                      color: whitecolor,
                      size: 14,
                      aligntext: TextAlign.left,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: state.downloadinglist.length);
          }
        }),
      ),
    );
  }
}
