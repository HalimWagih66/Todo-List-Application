import 'package:flutter/material.dart';

typedef FunctionValidate = String? Function(String?);
class CustomFormField extends StatelessWidget {
  final TextEditingController? inputField;
  final FunctionValidate functionValidate;
  final bool obscureText;
  final TextInputType textInputType;
  final String textLabel;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String fontFamily;
  final InputBorder? borderField;
  final Function? onPressedSuffixIcon;
  final int maxLines;
  final int minLines;
  final String? initialValue;
  final FunctionValidate? functionOcChanged;
  final TextInputAction? textInputAction;
  const CustomFormField(
      {super.key,
        this.inputField,
      required this.functionValidate,
      this.obscureText = false,
      this.textInputType = TextInputType.text,
      required this.textLabel,
      this.prefixIcon,
      this.suffixIcon,
      this.fontFamily = "Poppins",
       this.borderField,
        this.onPressedSuffixIcon,
        this.maxLines = 1,
        this.minLines = 1,
        this.functionOcChanged,
        this.initialValue,
        this.textInputAction
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      controller: inputField,
      validator: functionValidate,
      maxLines: maxLines,
      onChanged: functionOcChanged,
      initialValue: initialValue,
      minLines: minLines,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(letterSpacing: 1.5,decorationThickness: 0,fontSize: 15),
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          fontSize: 13
        ),
        labelStyle: Theme.of(context).textTheme.labelSmall,
        enabledBorder:borderField?.copyWith(borderSide: BorderSide(width: 1,style: BorderStyle.solid,color: Colors.grey.shade200)),
        focusedBorder: borderField,
        errorBorder: borderField?.copyWith(borderSide: const BorderSide(width: 1,style: BorderStyle.solid,color: Colors.red)),
        label: Text(textLabel),
        prefixIcon: prefixIcon != null ?Icon(
          prefixIcon,color: Colors.grey,
        ):null,

        suffixIcon: prefixIcon != null?IconButton(
          onPressed: (){
            onPressedSuffixIcon!();
          },
          icon: Icon(
            suffixIcon,
            color: Colors.grey,
          )
        ):null
      ),
    );
  }
}
