import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_downloader/application/convertbloc/getvedio/convert_bloc.dart';
import 'package:uni_downloader/consts/const.dart';
import 'package:uni_downloader/models/currentvalue_model.dart';

import 'package:uni_downloader/presentation/screens/homescreen/widgets/mediacontainer.dart';
import 'package:uni_downloader/presentation/screens/homescreen/widgets/showerror.dart';
import 'package:uni_downloader/presentation/screens/homescreen/widgets/showmessageclass.dart';
import 'package:uni_downloader/presentation/screens/homescreen/widgets/textwidget.dart';

class MediaBuilder extends StatelessWidget {
  MediaBuilder({super.key});
  final model = CurrentValue();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ConvertBloc, ConvertState>(
      builder: (context, state) {
        if (state.isentry == true) {
          return const ShowAnimation(
              error: '', animationurl: 'assets/welcome_animation.json');
        } else if (state.internetconnection == false) {
          return const ShowAnimation(
              error: 'Please Check Your InterNet Connection',
              animationurl: 'assets/error_animation.json');
        } else if (state.isloading == true) {
          return const ShowAnimation(
              error: '', animationurl: 'assets/animation_lnaapqrc.json');
        } else if (state.isurlerror == true) {
          return const ShowAnimation(
            animationurl: 'assets/error_animation.json',
            error: 'Please Enter Youtube Url',
            color: Colors.black,
          );
        } else if (state.downloadingerror == true) {
          return const ShowAnimation(
              error: 'Something Went Wrong',
              animationurl: 'assets/error_animation.json');
        } else if (state.folderisEmpty == true) {
          return const ShowMessage(
            message: "CAN'T FIND DOWNLOAD FOLDER...",
            messagecolor: messagecolor,
          );
        } else if (state.isdownloading == true) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                color: greencolor,
                minHeight: 17,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(
                height: 8,
              ),
              TextWidget(
                text: 'Downloading....',
                weight: FontWeight.w500,
              )
            ],
          );
        } else if (state.isdownloading == false) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowDownloadComplited(
                  message: '', animationurl: 'assets/download_complited.json'),
              ShowMessage(
                message: 'DOWNLOAD COMPLETED',
                messagecolor: greencolor,
              )
            ],
          );
        } else if (state.alreadyExist == true) {
          return const ShowMessage(
              message: 'MEDIA IS ALREADY EXIST...!',
              messagecolor: messagecolor);
        }

        return SingleChildScrollView(
          child: MediaContainer(
            isvisible: true,
            title: model.currentTitle,
            image: model.curerntThumbnail,
            duration: model.currentDuration,
            thumbnaiwidth: size.width,
            thumbnaiheight: size.width / 1.4,
            width: size.width,
            allpadding: 10,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
