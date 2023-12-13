import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/Features/auth/sign_up/presentation/view/widget/pin_theme_otp.dart';
import 'package:todo_list_application/Features/auth/sign_up/presentation/view_model/sign_up_view_model.dart';
import 'package:todo_list_application/provider/edit_phone_number_provider.dart';
import 'package:todo_list_application/provider/user_information_provider.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.pinController});

  final TextEditingController pinController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Text(
          "Verify Your",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Phone Number",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Text(
            "Enter Your  OTP code here",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        Pinput(
          length: 6,
          controller: pinController,
          focusedPinTheme: pinThemeOtp(context: context,colorBorderPin: Colors.blue,colorTextPin: Colors.blue),
          errorPinTheme: pinThemeOtp(context: context,colorBorderPin: Colors.blue,colorTextPin: Colors.blue),
          defaultPinTheme: pinThemeOtp(context: context,colorBorderPin: Colors.transparent,colorTextPin: Colors.black),
          onCompleted: (value) async{
            if(Provider.of<EditPhoneNumberProvider>(context,listen: false).isUserSocial){
              Provider.of<EditPhoneNumberProvider>(context,listen: false).verifySmsCode(value, Provider.of<SignUpViewModel>(context,listen: false).verificationId!, context,Provider.of<SignUpViewModel>(context,listen: false).phoneNumber!.completeNumber!);
            }else{
              await Provider.of<SignUpViewModel>(context,listen: false).verifySmsCode(value);
            }
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
        ),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('OTP not received?',style: Theme.of(context).textTheme.displaySmall,
              ),
              GestureDetector(
                  child: Text(' RESEND', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.blue)),
                  onTap: ()async {
                    if(Provider.of<EditPhoneNumberProvider>(context).userCredential != null){
                      await Provider.of<SignUpViewModel>(context,listen: false).verifyPhoneNumber(isResendSms: true,userCredential:Provider.of<EditPhoneNumberProvider>(context,listen: false).userCredential! );
                    }else{
                      await Provider.of<SignUpViewModel>(context,listen: false).verifyPhoneNumber(isResendSms: true,userCredential:Provider.of<SignUpViewModel>(context,listen: false).userCredential! );
                    }
                    pinController.text = "";
                  },
                ),
            ],
          ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Text('Edit ', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.blue)),
              onTap: ()async {
                Provider.of<SignUpViewModel>(context,listen: false).navigator.controlPageViewBuilder(4);
                pinController.text = "";
              },
            ),
            Text('Your Phone Number',style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ],
    );
  }

}
