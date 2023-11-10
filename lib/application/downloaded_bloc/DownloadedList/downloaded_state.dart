part of 'downloaded_bloc.dart';

class DownloadedState {
  final bool isloading;
  final List<DownnLoadedTile> downloadinglist;

  DownloadedState({required this.isloading, required this.downloadinglist});
}

class DownloadedInitial extends DownloadedState {
  DownloadedInitial({required super.isloading, required super.downloadinglist});
}
