import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/Features/auth/continue_account/navigator/continue_account_navigator.dart';
import 'package:todo_list_application/Features/auth/continue_account/view/widgets/button_continue_account.dart';
import 'package:todo_list_application/Features/auth/continue_account/view/widgets/custom_line.dart';
import 'package:todo_list_application/Features/auth/continue_account/view_model/continue_account_view_model.dart';
import 'package:todo_list_application/Features/auth/continue_account_with_email/view/continue_with_email_view.dart';
import 'package:todo_list_application/core/base/base_state.dart';
import 'package:todo_list_application/core/style/colors/application_color.dart';
import 'package:todo_list_application/provider/edit_phone_number_provider.dart';
import 'package:todo_list_application/provider/user_information_provider.dart';

import '../../model/info_user_model.dart';
import '../../sign_up/presentation/view/sign_up_view.dart';

class ContinueAccountView extends StatefulWidget {
  const ContinueAccountView({super.key});

  static const routeName = "ContinueAccount";

  @override
  State<ContinueAccountView> createState() => _ContinueAccountViewState();
}

class _ContinueAccountViewState
    extends BaseState<ContinueAccountView, ContinueAccountViewModel>
    implements ContinueAccountNavigator {
  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
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
                child: Text("Set up your profile",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onPressed: () {
                    viewModel.goToScreen(
                        routeName: ContinueAccountWithEmailView.routeName);
                  },
                  child: Text(
                    "Continue with email",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  )),
              const CustomLine(),
              ButtonContinueAccount(
                  onLongPress: () async {
                    await viewModel.signOutFromGoogle();
                  },
                  onPressed: () async {
                    await viewModel.signInWithGoogle();
                  },
                  image: "assets/images/auth/continue account/google_icon.png",
                  text: "Continue with Google"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ButtonContinueAccount(
                    onLongPress: () async {},
                    onPressed: () async {
                      await viewModel.signInWithFacebook();
                    },
                    icon: Icons.facebook,
                    text: "Continue with Facebook"),
              ),
              ButtonContinueAccount(
                  onLongPress: () async {
                    viewModel.signOutFromTwitter();
                  },
                  onPressed: () async {},
                  image: "assets/images/auth/continue account/Twitter-icon.png",
                  text: "Continue with Twitter"),
            ],
          ),
        ));
  }

  @override
  ContinueAccountViewModel initViewModel() {
    return ContinueAccountViewModel();
  }

  @override
  void initializeInformationUserModel(UserCredential userCredential) {
    Provider.of<UserInformationProvider>(context, listen: false)
            .informationUserModel =
        InformationUserModel(
            pathImage: userCredential.user?.photoURL,
            isAccountSocial: true,
            email: userCredential.user?.email,
            phoneNumber: userCredential.user?.phoneNumber,
            fullName: userCredential.user?.displayName);
    print(Provider.of<UserInformationProvider>(context, listen: false)
        .informationUserModel);
  }

  @override
  void connectEditPhoneNumber() {
    Provider.of<EditPhoneNumberProvider>(context, listen: false)
        .userCredential = viewModel.userCredential;
    Provider.of<EditPhoneNumberProvider>(context, listen: false).isUserSocial =
        true;
  }

  @override
  void pushScreenSignUpAndRemoveUntil() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignUpView(selectedPage: 4),
        ),
        (route) => false);
  }
}
