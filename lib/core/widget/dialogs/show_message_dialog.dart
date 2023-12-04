import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showMessageWithDialog({
    required BuildContext context,
    required String message,
    required DialogType dialogType,
    String? title,
    String? posActionName,
    Function? posAction,
    String? nigActionName,
    Function? nigAction,
  }) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dialogBackgroundColor: const Color(0xff141922),
      context: context,
      dialogType: dialogType,
      title: title,
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      animType: AnimType.rightSlide,
      desc: message,
      btnCancelOnPress: nigActionName != null
          ? () {
        nigAction?.call();
      }
          : null,
      btnOkOnPress: posActionName != null
          ? () {
        posAction?.call();
      }
          : null,
      btnOkText: posActionName,
      btnCancelText: nigActionName,
    ).show();
}
