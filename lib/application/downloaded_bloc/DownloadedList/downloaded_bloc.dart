import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_downloader/infrastructure/downloadedfile_imp.dart';
import 'package:uni_downloader/models/downloaded_model.dart';

part 'downloaded_event.dart';
part 'downloaded_state.dart';

class DownloadedBloc extends Bloc<DownloadedEvent, DownloadedState> {
  DownloadedBloc()
      : super(DownloadedInitial(isloading: false, downloadinglist: [])) {
    ManageDownloadList impli = ManageDownloadList();
    on<DownloadedList>((event, emit) => getDBList(event, emit, impli));
    on<DeleteAll>((event, emit) => deleteAll(event, emit, impli));
  }
}
// GET ALL DOWNLOADED FILE FUNCTION

getDBList(DownloadedList event, Emitter<DownloadedState> emit,
    ManageDownloadList downloadlist) async {
  emit(DownloadedState(isloading: true, downloadinglist: []));
  await Future.delayed(const Duration(milliseconds: 500));

  final list = await downloadlist.getDownLoadlist();

  return emit(DownloadedState(isloading: false, downloadinglist: list));
}

// DELETE ALL FUNCTION

deleteAll(DeleteAll event, Emitter<DownloadedState> emit,
    ManageDownloadList downloadlist) async {
  emit(DownloadedState(isloading: true, downloadinglist: []));
  final dblist = await downloadlist.deleteAll();
  emit(DownloadedState(isloading: false, downloadinglist: dblist));
}
