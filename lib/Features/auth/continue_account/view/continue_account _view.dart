import 'package:flutter/material.dart';
import 'package:todo_list_application/Features/auth/continue_account/navigator/continue_account_navigator.dart';
import 'package:todo_list_application/Features/auth/continue_account/view/widgets/button_continue_account.dart';
import 'package:todo_list_application/Features/auth/continue_account/view/widgets/custom_line.dart';
import 'package:todo_list_application/Features/auth/continue_account/view_model/continue_account_view_model.dart';
import 'package:todo_list_application/Features/auth/sign_up/view/sign_up_view.dart';
import 'package:todo_list_application/core/base/base_state.dart';

class ContinueAccount  extends StatefulWidget {
  const ContinueAccount ({super.key});
  static const routeName = "ContinueAccount";
  @override
  State<ContinueAccount> createState() => _ContinueAccountState();
}

class _ContinueAccountState extends BaseState<ContinueAccount,ContinueAccountViewModel> implements ContinueAccountNavigator{
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text("Set up your profile",textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleLarge),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: const Color(0xff3598db),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)
                ),
                onPressed: (){
                  viewModel.goToScreen(SignUpView.routeName);
                },
                child: Text("Continue with email",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),)
            ),
            const CustomLine(),
             ButtonContinueAccount(
               onLongPress: () async{
                 await viewModel.signOutFromGoogle();
               },
              onPressed:() async{
                viewModel.signInWithGoogle();
              },
              image: "assets/images/auth/continue account/google_icon.png",
              text:  "Continue with Google"
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ButtonContinueAccount(
                  onLongPress: () async{

                  },
                  onPressed:() async{
                    await viewModel.signInWithFacebook();
                  },
                  icon: Icons.facebook,
                  text:  "Continue with Facebook"
              ),
            ),
            ButtonContinueAccount(
                onLongPress: () async{
                  viewModel.signOutFromTwitter();
                },
                onPressed:() async{
                  viewModel.signInWithTwitter(context);
                },
                image: "assets/images/auth/continue account/Twitter-icon.png",
                text:  "Continue with Twitter"
            ),
          ],
        ),
      )
    );
  }
  @override
  ContinueAccountViewModel initViewModel() {
    return ContinueAccountViewModel();
  }
}
