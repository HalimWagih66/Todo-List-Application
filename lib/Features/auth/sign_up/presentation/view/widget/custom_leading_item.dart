import 'package:flutter/material.dart';

class CustomLeadingItem extends StatelessWidget{
  const CustomLeadingItem({super.key,required this.colorIcon, required this.onPressed});
  final Color colorIcon;
  final Function onPressed;
  @override
  GestureDetector build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          onPressed();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: colorIcon,
        )
    );
  }
}