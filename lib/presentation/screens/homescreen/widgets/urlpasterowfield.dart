import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_downloader/application/convertbloc/getvedio/convert_bloc.dart';
import 'package:uni_downloader/consts/const.dart';
import 'package:uni_downloader/presentation/screens/homescreen/widgets/buttons.dart';
import 'package:uni_downloader/presentation/screens/homescreen/widgets/textfield.dart';

final textcontroll = TextEditingController();

class UrlPasteFieldRow extends StatelessWidget {
  const UrlPasteFieldRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: TextFieldWidget(
            textcontroll: textcontroll,
            backgroundcolor: whitecolor,
          ),
        )),
        InkWell(
          onTap: () {
            final text = textcontroll.text;
            FocusScope.of(context).unfocus();
            BlocProvider.of<ConvertBloc>(context).add(VedioInfo(uri: text));
          },
          child: const ButtonWidget(
            width: 60,
            height: 50,
            radius: 13,
            color: greencolor,
            child: Icon(
              Icons.search_outlined,
              color: whitecolor,
            ),
          ),
        )
      ],
    );
  }
}
