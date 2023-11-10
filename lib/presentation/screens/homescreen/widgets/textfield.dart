import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_downloader/application/convertbloc/getvedio/convert_bloc.dart';

class TextFieldWidget extends StatelessWidget {
  final Color? backgroundcolor;

  final TextEditingController textcontroll;

  const TextFieldWidget(
      {Key? key, this.backgroundcolor, required this.textcontroll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: backgroundcolor,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: textcontroll,
        textInputAction: TextInputAction.done,
        onSubmitted: (value) {
          BlocProvider.of<ConvertBloc>(context).add(VedioInfo(uri: value));
        },
        decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: 'Paste Url',
            contentPadding: EdgeInsets.only(left: 10, top: 20)),
      ),
    );
  }
}
