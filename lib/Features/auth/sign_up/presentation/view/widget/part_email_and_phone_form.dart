import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/Features/auth/sign_up/presentation/view_model/sign_up_view_model.dart';
import '../../../../../../core/functions/validate/validation Email.dart';
import '../../../../../../core/widget/TextFormField/custom_form_field.dart';
import 'custom_phone_number_input.dart';

class PartEmailAndPasswordForm extends StatelessWidget {
  PartEmailAndPasswordForm(
      {super.key,
      required this.emailController,
      required this.phoneNumberController});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  @override
  Widget build(BuildContext context) {
    var signUpViewModel = Provider.of<SignUpViewModel>(context,listen: false);
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 7),
            child: Text(
              "Enter Your Phone And Your Password",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          CustomFormField(
            hintText: "",
            textLabel: AppLocalizations.of(context)!.email_address,
            inputField: emailController,
            functionValidate: (text) {
              if (text?.isEmpty == true || text?.trim().isEmpty == true) {
                return AppLocalizations.of(context)!.please_enter_email_address;
              }
              if (!ValidationEmail.isEmail(text!)) {
                return AppLocalizations.of(context)!.please_enter_the_email_correctly;
              }
            },
            borderField: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid, width: 2)),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomPhoneNumberInput(
                onInputChanged: (PhoneNumber number){
                  signUpViewModel.onInputChangedPhoneNumberInput(number);
                },
              onInputValidated: (bool value){
                signUpViewModel.onInputValidatedPhoneNumberInput(value);
              },
              validator: (PhoneNumber value){
                return signUpViewModel.validatorPhoneNumberInput();
              },
              phoneNumberController: phoneNumberController
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: AnimatedButton(
              pressEvent: () {
                pressEvent(context);
              },
              width: 250,
              buttonTextStyle: Theme.of(context).textTheme.displayMedium,
              color: const Color(0xff5D9CEC),
              text: AppLocalizations.of(context)!.create_account,
            ),
          )
        ],
      ),
    );
  }

  void pressEvent(BuildContext context) async {
    var signUpViewModel = Provider.of<SignUpViewModel>(context, listen: false);
    if (formKey.currentState?.validate() == true) {
      signUpViewModel.email = emailController.text;
      await signUpViewModel.createAccount(context);
    }
  }
}
