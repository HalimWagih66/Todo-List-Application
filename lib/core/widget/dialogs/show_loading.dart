import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showLoadingDialog(BuildContext context) async{
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color(0xff141922),
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 14),
            Text(AppLocalizations.of(context)!.loading,style: const TextStyle(color: Colors.white)),
          ],
        ),
      );
    },
    barrierDismissible: false,
  );
}