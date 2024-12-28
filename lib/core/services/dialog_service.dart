import 'package:flutter/material.dart';
import 'package:movie_explorer/core/constants/lang_keys.dart';
import 'package:movie_explorer/core/widgets/alert_dialog_widget.dart';
import 'package:movie_explorer/main.dart';

class DialogService {
  void showErrorDialog(String msg) {
    if (navigatorKey.currentContext == null) {
      print(msg);
      return;
    }
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (_) => AlertDialogWidget(
              title: LangKeys.error,
              colorText: Colors.red,
              content: msg,
            ));
  }
}
