import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../view_model/sign_up_view_model.dart';
import 'customFieldPasswordSignUp.dart';
import 'custom_icon_navigate_between_pages.dart';

class PartPasswordForm extends StatelessWidget {
   PartPasswordForm({super.key, required this.passwordController, required this.passwordConfirmationController});
   final TextEditingController passwordController;
   final TextEditingController passwordConfirmationController;
   GlobalKey<FormState> formKey = GlobalKey<FormState>();
   @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28.0,horizontal: 7),
            child: Text(AppLocalizations.of(context)!.create_a_password,style: Theme.of(context).textTheme.titleLarge,),
          ),

          CustomFieldPasswordSignUp(
            textLabel: AppLocalizations.of(context)!.password,
              controller: passwordController,
            functionValidate: (String text){
            if (text == null || text.isEmpty == true || text.trim().isEmpty == true) {
              return AppLocalizations.of(context)!.please_enter_password;
            }
            if (text!.length < 6) {
              return AppLocalizations.of(context)!.please_enter_a_password_that_is_more_than_6_digits;
            }
          },
          ),
          const SizedBox(
            height: 40,
          ),
          CustomFieldPasswordSignUp(
            textLabel:AppLocalizations.of(context)!.confirm_password ,
              controller: passwordConfirmationController,
            functionValidate: (String text){
                if (text != passwordConfirmationController.text) {
                  print("text = $text firstPassword $passwordConfirmationController.text");
                  return AppLocalizations.of(context)!
                      .this_password_does_not_match_the_main_password;
                }
            },
          ),
          CustomIconNavigateBetweenPages(onPressed:() {
            onPressedCustomIconNext(context);
          }, iconData: Icons.navigate_next_outlined,
          )
        ],
      ),
    );
  }
  void onPressedCustomIconNext(BuildContext context)async{
     var signUpViewModel = Provider.of<SignUpViewModel>(context, listen: false);
     if (formKey.currentState?.validate() != true) return;
     signUpViewModel.navigator.controlPageViewBuilder(2);
     signUpViewModel.password = passwordController.text;
  }
}
