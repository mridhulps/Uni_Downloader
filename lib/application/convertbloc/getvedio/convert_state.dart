part of 'convert_bloc.dart';

class ConvertState {
  final bool isckeckingcomplited;
  final String? progress;
  final bool? isdownloading;
  final bool? isloading;
  final bool? isurlerror;
  final bool? isentry;
  bool alreadyExist;
  final bool? downloadingerror;
  final bool? internetconnection;
  final bool? somethingerror;
  bool folderisEmpty;
  bool ischecking;

  ConvertState(
      {this.isckeckingcomplited = false,
      this.isloading,
      this.isdownloading,
      this.progress = '0',
      this.isurlerror,
      this.isentry,
      this.downloadingerror = false,
      this.internetconnection = true,
      this.somethingerror = false,
      this.alreadyExist = false,
      this.folderisEmpty = false,
      this.ischecking = false});
}

class Initial extends ConvertState {
  Initial({
    super.isloading,
    super.progress = '0',
    super.isurlerror = false,
    super.isentry = true,
  });
}
