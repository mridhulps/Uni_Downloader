part of 'convert_bloc.dart';

class ConvertEvent {}

class VedioInfo extends ConvertEvent {
  final String uri;

  VedioInfo({required this.uri});
}

class DownloadMp3 extends ConvertEvent {
  //final String seconduri;
  final BuildContext context;

  DownloadMp3({ required this.context});
}

class DownLoadMp4 extends ConvertEvent {
  final String thirdurl;

  DownLoadMp4({required this.thirdurl});
}

class Sharingtext extends ConvertEvent {
  final String sharedstring;

  Sharingtext({required this.sharedstring});
}


class AlreadyExistError extends ConvertEvent {}

class AnalyzingData extends ConvertEvent {}
