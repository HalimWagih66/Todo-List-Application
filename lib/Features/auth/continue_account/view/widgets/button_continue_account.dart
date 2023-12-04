import 'package:flutter/material.dart';

class ButtonContinueAccount extends StatelessWidget {
  const ButtonContinueAccount({super.key, required this.text, this.image, required this.onPressed, required this.onLongPress, this.icon});
  final String text;
  final String? image;
  final IconData? icon;
  final  Future<void> Function() onPressed;
  final  Future<void> Function() onLongPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onLongPress: () {
        onLongPress();
      },
      onPressed: () {
      onPressed();
    },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: const BorderSide(style: BorderStyle.solid,color: Colors.black,width: 2))
      ), child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          image != null?Expanded(child: SizedBox(height: 23, child: Image.asset(image!))):
          Expanded(child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: SizedBox(height: 20, child: Icon(icon,color: Colors.blue,size: 32,)),
          )),
          Expanded(flex: 3,child: Text(text,style: Theme.of(context).textTheme.titleMedium))
        ],
      ),
    );
  }
}
