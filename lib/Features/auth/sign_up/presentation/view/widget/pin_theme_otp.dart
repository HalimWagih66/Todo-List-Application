import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

PinTheme pinThemeOtp(
    {required BuildContext context, required Color colorBorderPin, required Color colorTextPin}) {
  return PinTheme(
    textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: colorTextPin),
    decoration: BoxDecoration(
      color: const Color(0xFFE8ECF3),
      border:
          Border.all(color: colorBorderPin, width: 1, style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.all(20),
  );
}
