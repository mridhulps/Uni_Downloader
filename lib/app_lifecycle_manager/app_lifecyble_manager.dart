import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'package:uni_downloader/infrastructure/receivemedia.dart';

class AppLifecycleManager extends StatefulWidget {
  final Widget child;
  const AppLifecycleManager({super.key, required this.child});

  @override
  State<AppLifecycleManager> createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    initialtext(context);
    super.initState();
  }

  @override
  void dispose() {
    log('dispose called');
    WidgetsBinding.instance.removeObserver(this);
    textstream.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      log('PAUSED STATE');

      textstream = ReceiveSharingIntent.getTextStream().listen((event) {
        value = event;
      
      });
    } else if (state == AppLifecycleState.inactive) {

    } else if (state == AppLifecycleState.resumed) {
      if (value.isEmpty) {
        return;
      } else {
         manageurl(context, value.toString());
      }
      value='';

      log('RESUMED STATE');
    } else if (state == AppLifecycleState.detached) {
      textstream.cancel();
      log('DITACHED STATE');
    }
    super.didChangeAppLifecycleState(state);
  }

  String value = '';
  late StreamSubscription<String> textstream;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
