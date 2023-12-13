import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/Features/auth/sign_up/presentation/view_model/sign_up_view_model.dart';
import 'package:todo_list_application/provider/edit_phone_number_provider.dart';
import 'custom_icon_navigate_between_pages.dart';
import 'custom_phone_number_input.dart';

class EditPhoneNumber extends StatelessWidget {
    EditPhoneNumber({super.key, required this.phoneNumberController});
  final TextEditingController phoneNumberController;
   var formKeyEditPhoneNumber = GlobalKey<FormState>();
   @override
  Widget build(BuildContext context) {
    SignUpViewModel signUpViewModel = Provider.of<SignUpViewModel>(context,listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),

        Text("Verify Your Number",style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 15,),
        Text("please Enter your mobile number",style: Theme.of(context).textTheme.displaySmall),
        Text("to receive verification code",style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 15,),

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

        CustomIconNavigateBetweenPages(onPressed:() {
          onPressedCustomIconNext(context);
        }, iconData: Icons.navigate_next_outlined,
          isNext: false,
        )
      ],
    );
  }
  void onPressedCustomIconNext(BuildContext context)async{

   var signUpViewModel = Provider.of<SignUpViewModel>(context, listen: false);
    print("onPressedCustomIconNext ${signUpViewModel.pageController.hasClients} ");
    if (signUpViewModel.isPhoneNumberValid != true) return;
   signUpViewModel.selectedPage = null;
   if(Provider.of<EditPhoneNumberProvider>(context,listen: false).userCredential != null){
      await signUpViewModel.verifyPhoneNumber(isResendSms: true,userCredential:Provider.of<EditPhoneNumberProvider>(context,listen: false).userCredential! );
    }else{
      await signUpViewModel.verifyPhoneNumber(userCredential:signUpViewModel.userCredential!);
    }
   }
}
