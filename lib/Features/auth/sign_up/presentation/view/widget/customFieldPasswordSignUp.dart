import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/widget/TextFormField/custom_form_field.dart';
import '../../view_model/sign_up_view_model.dart';

class CustomFieldPasswordSignUp extends StatelessWidget {
  const CustomFieldPasswordSignUp({super.key, required this.controller,required this.textLabel, required this.functionValidate});
  final TextEditingController controller;
  final String textLabel;
  final Function functionValidate;
  @override
  Widget build(BuildContext context) {
    SignUpViewModel signUpViewModel = Provider.of<SignUpViewModel>(context);
    return CustomFormField(
      hintText: "*********",
      textLabel: textLabel,
      inputField: controller,
      functionValidate: (text) {
        functionValidate(text);
      },
      borderField: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.blue,
              style: BorderStyle.solid,
              width: 1)),
      onPressedSuffixIcon: () {
        signUpViewModel.onPressedSuffixIcon();
      },
      suffixIcon: signUpViewModel.eyePassword,
      obscureText: signUpViewModel.isHidePassword,
    );
  }
}
