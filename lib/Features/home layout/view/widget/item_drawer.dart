import 'package:flutter/material.dart';

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({super.key, required this.iconData, required this.text});
  final IconData iconData;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(iconData,color: Colors.white,),
            const SizedBox(width: 12,),
            Text(text,style: Theme.of(context).textTheme.displayMedium,),
          ],
        ),
        const SizedBox(height: 13)
      ],
    );
  }
}
