import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uni_downloader/application/downloaded_bloc/DownloadedList/downloaded_bloc.dart';
import 'package:uni_downloader/presentation/screens/homescreen/widgets/popup_menu_button.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BlocBuilder<DownloadedBloc, DownloadedState>(builder: (
        context,
        state,
      ) {
        final length = state.downloadinglist.length;
        return Text('History -$length');
      }),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: PopupMenuButtonWidget(
            menulist: [
              item('DeleteAll', 4),
            ],
          ),
        ),
      ],
    );
  }
}
