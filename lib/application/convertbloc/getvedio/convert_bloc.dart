// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:io';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uni_downloader/infrastructure/downloadedfile_imp.dart';

import 'package:uni_downloader/infrastructure/getvedio.dart';
import 'package:uni_downloader/infrastructure/receivemedia.dart';
import 'package:uni_downloader/models/currentvalue_model.dart';

import 'package:uni_downloader/models/downloaded_model.dart';

import 'package:uni_downloader/presentation/screens/homescreen/widgets/urlpasterowfield.dart';

part 'convert_event.dart';
part 'convert_state.dart';

String title = '';
Duration durations = Duration.zero;

class ConvertBloc extends Bloc<ConvertEvent, ConvertState> {
  ConvertBloc() : super(Initial(isloading: false)) {
    GetvedioInformation vedioinfo = GetvedioInformation();
    ManageDownloadList downloadlist = ManageDownloadList();
    CurrentValue model = CurrentValue();

    on<VedioInfo>((event, emit) => vediogetinfo(event, emit, vedioinfo, model));

    on<AnalyzingData>((event, emit) => analyzingData(event, emit, vedioinfo));

    on<DownloadMp3>((event, emit) =>
        downloadmp3(event, emit, vedioinfo, downloadlist, model));

    on<DownLoadMp4>((event, emit) =>
        downloadvedio(event, emit, vedioinfo, downloadlist, model));
  }
}

vediogetinfo(VedioInfo event, Emitter<ConvertState> emit,
    GetvedioInformation vedioinfo, CurrentValue model) async {
  final receivevalue = event.uri;

  emit(ConvertState(
    isloading: true,
    isurlerror: false,
  ));

  if (receivevalue.isEmpty) {
    return emit(ConvertState(
      isloading: false,
      isurlerror: false,
      isentry: true,
    ));
  } else {
    textcontroll.text = event.uri;
    try {
      final result = await vedioinfo.getvedioinfo(event.uri.toString());

      final titles = result['Title'];

      final author = result['Author'];

      final duration = result['Duration'];

      final image = result['Thumbnail'];

      final audiosize = result['Mp3size'];

      await model.addCurrentValue(titles, author, image, duration, audiosize);

      emit(ConvertState(
        isloading: false,
        isurlerror: false,
        isentry: false,
      ));

      final status = await setdata(receivevalue.toString());
      if (status == true) {
        log('SUCCESSFULLY SAVED VALUE');
      } else {
        log('NOT SAVED VALUE');
      }
    } on SocketException catch (_) {
      emit(ConvertState(
        internetconnection: false,
        isentry: false,
      ));
    } catch (e) {
      emit(ConvertState(
        isloading: false,
        isurlerror: true,
        isentry: false,
      ));
    }
  }
}

//ANALYZING DOWNLOAD FOLDER

analyzingData(AnalyzingData event, Emitter<ConvertState> emit,
    GetvedioInformation vedioinfo) async {
  emit(ConvertState(
    ischecking: true,
  ));
  await Future.delayed(const Duration(seconds: 1));

  final isdownloaddir = await getDownLoadDirectory();

  if (isdownloaddir.isEmpty) {
    return emit(ConvertState(
      ischecking: false,
      folderisEmpty: true,
    ));
  } else {
    return emit(ConvertState(
      ischecking: false,
      isckeckingcomplited: true,
    ));
  }
}
// THEN DOWNLOAD MP3

downloadmp3(
    DownloadMp3 event,
    Emitter<ConvertState> emit,
    GetvedioInformation vedioinfo,
    ManageDownloadList downloaded,
    CurrentValue model) async {
  emit(ConvertState(
    isdownloading: true,
  ));
  await Future.delayed(const Duration(seconds: 1));

  final directorypath = Directory('/storage/emulated/0/Download');
  final currenttitle = 'YD-${vedioinfo.currenttitle.toString()}.mp3';

  final isexist = await isExistInDownloadDirectory(directorypath, currenttitle);

  if (isexist == true) {
    return emit(ConvertState(
      ischecking: false,
      alreadyExist: true,
    ));
  } else {
    try {
      final status = await vedioinfo.downloadaudiomp3(directorypath.path);

      if (status == true) {
        final title = '${model.currentTitle}.mp3';
        final author = model.currentAuthor;
        final image = model.curerntThumbnail;

        final addModel =
            DownnLoadedTile(title: title, author: author, image: image);

        downloaded.addtoDataBase(addModel);

        return emit(ConvertState(
          isdownloading: false,
        ));
      } else {
        return emit(ConvertState(
          downloadingerror: false,
        ));
      }
    } on SocketException catch (_) {
      return emit(ConvertState(
        internetconnection: false,
      ));
    } on PathAccessException catch (_) {
      return emit(ConvertState(
        downloadingerror: true,
      ));
    } catch (_) {
      return emit(ConvertState(
        downloadingerror: true,
      ));
    }
  }
}

//DOWNLOAD MP4

downloadvedio(
    DownLoadMp4 event,
    Emitter<ConvertState> emit,
    GetvedioInformation vedioinfo,
    ManageDownloadList downloaded,
    CurrentValue model) async {
  emit(ConvertState(
    isdownloading: true,
  ));

  await Future.delayed(const Duration(seconds: 1));

  final directory = Directory('/storage/emulated/0/Download');
  final currentvedio = 'YD-${vedioinfo.currenttitle.toString()}.mp4';

  final status = await isExistInDownloadDirectory(directory, currentvedio);
  if (status == true) {
    return emit(ConvertState(
      alreadyExist: true,
    ));
  } else {
    try {
      final status = await vedioinfo.downloadmp4(directory.path);

      if (status == true) {
        final dbmodel = DownnLoadedTile(
            title: '${model.currentTitle}.mp4',
            author: model.currentAuthor,
            image: model.curerntThumbnail);

        downloaded.addtoDataBase(dbmodel);

        return emit(ConvertState(
          isdownloading: false,
        ));
      } else {
        emit(ConvertState(
          downloadingerror: true,
        ));
      }
    } on SocketException catch (_) {
      emit(ConvertState(
        isloading: false,
        internetconnection: false,
      ));
    } catch (e) {
      emit(ConvertState(
        isloading: false,
        downloadingerror: true,
      ));
    }
  }
}
