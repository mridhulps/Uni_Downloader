// ignore_for_file: use_build_context_synchronously, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:uni_downloader/application/convertbloc/getvedio/convert_bloc.dart';

import 'package:uni_downloader/main.dart';

import 'package:uni_downloader/presentation/screens/homescreen/widgets/urlpasterowfield.dart';

Future<String?> sharetext() async {
  String? data;

  StreamSubscription<String> _streamsub;

  _streamsub = ReceiveSharingIntent.getTextStream().listen((event) {
    data = event;
  }, onError: (error) {
    log('STERAM ONERROR CALLED=${error.toString()}');
  }, onDone: () {
    log('STERAM ONDONE CALLED');
  });

  data = await ReceiveSharingIntent.getInitialText();

  return data;
}

Future<bool> setdata(String value) async {
  sharedpref.clear();

  final status = await sharedpref.setString('STOREKEY', value);

  return status;
}

Future<String?> getdata() async {
  final value = sharedpref.getString('STOREKEY');

  return value;
}

initialtext(BuildContext context) async {
  String getvalue = '';

  await ReceiveSharingIntent.getInitialText().then((value) {
    getvalue = value ?? '';
  });
  manageurl(context, getvalue.toString());
}

void refreshdata(BuildContext context, String s) {
  textcontroll.clear();
  BlocProvider.of<ConvertBloc>(context).add(VedioInfo(uri: ''));
}

Future<void> manageurl(BuildContext context, String url) async {
  if (url.isEmpty) {
    final getvalue = await getdata();

    if (getvalue == null || getvalue.isEmpty) {
      return;
    } else {
      BlocProvider.of<ConvertBloc>(context).add(VedioInfo(uri: getvalue));
    }
  } else {
    BlocProvider.of<ConvertBloc>(context).add(VedioInfo(uri: url.toString()));
  }
}
