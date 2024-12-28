import 'package:flutter/material.dart';
import 'package:movie_explorer/core/constants/lang_keys.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget(
      {required this.title, required this.content, this.colorText, super.key});

  final String title;
  final String content;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: colorText ?? Colors.green),
          child: Text(
            LangKeys.ok,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
