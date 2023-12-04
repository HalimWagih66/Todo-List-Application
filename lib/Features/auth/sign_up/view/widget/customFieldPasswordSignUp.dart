import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/Features/auth/sign_up/view_model/sign_up_view_model.dart';
import '../../../../../core/widget/TextFormField/custom_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomFieldPasswordSignUp extends StatelessWidget {
  const CustomFieldPasswordSignUp({super.key, required this.controller, this.checkMatchPassword = false, this.firstPassword});
  final TextEditingController controller;
  final String? firstPassword;
  final bool checkMatchPassword;
  @override
  Widget build(BuildContext context) {
    SignUpViewModel signUpViewModel = Provider.of<SignUpViewModel>(context);
    return CustomFormField(
      textLabel: AppLocalizations.of(context)!.password,
      inputField: controller,
      functionValidate: (text) {
        if (text == null || text.isEmpty == true || text.trim().isEmpty == true) {
          return AppLocalizations.of(context)!.please_enter_password;
        }
        if (text!.length < 6 && checkMatchPassword == false) {
          return AppLocalizations.of(context)!.please_enter_a_password_that_is_more_than_6_digits;
        }else{
          if (text != firstPassword) {
            return AppLocalizations.of(context)!
                .this_password_does_not_match_the_main_password;
          }
        }
      },
      borderField: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.blue,
              style: BorderStyle.solid,
              width: 1)),
      onPressedSuffixIcon: () {
        signUpViewModel.onPressedSuffixIcon();
      },
      prefixIcon: Icons.password,
      suffixIcon: signUpViewModel.eyePassword,
      obscureText: signUpViewModel.isHidePassword,
    );
  }
}
