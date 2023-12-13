import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/widget/TextFormField/custom_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../view_model/login_view_model.dart';

class CustomFieldPassword extends StatelessWidget {
  const CustomFieldPassword({super.key, required this.passwordController});
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    return CustomFormField(
      hintText: "*********",
      textLabel: AppLocalizations.of(context)!.password,
      inputField: passwordController,
      functionValidate: (text) {
        if (text == null || text.isEmpty == true || text.trim().isEmpty == true) {
          return AppLocalizations.of(context)!.please_enter_password;
        }
        if (text!.length < 6) {
          return AppLocalizations.of(context)!.please_enter_a_password_that_is_more_than_6_digits;
        }
      },
      borderField: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.blue,
              style: BorderStyle.solid,
              width: 1)),
      onPressedSuffixIcon: () {
        loginViewModel.onPressedSuffixIcon();
      },
      suffixIcon: loginViewModel.eyePassword,
      obscureText: loginViewModel.isHidePassword,
    );
  }
}
