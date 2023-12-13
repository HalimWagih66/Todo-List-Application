import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_list_application/Features/auth/Dao/users_dao.dart';
import 'package:todo_list_application/Features/auth/model/user_social_model.dart';
import 'package:todo_list_application/Features/onboarding/view/using_app_view.dart';
import 'package:todo_list_application/core/widget/dialogs/hide_dialog.dart';
import 'package:todo_list_application/core/widget/dialogs/show_loading.dart';
import 'package:todo_list_application/core/widget/dialogs/show_message.dart';
import '../Features/auth/continue_account/view/continue_account_view.dart';

class EditPhoneNumberProvider {
  bool isUserSocial = false;
  String? phoneNumber;
  UserCredential? userCredential;
  Future<void> verifySmsCode(String smsCode,String verificationId,BuildContext context,String phoneNumber) async {
    showLoadingDialog(context);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!, smsCode: smsCode);
      this.phoneNumber = phoneNumber;
      await editNumberPhoneInFireStoreAfterEdit();
      hideDialog(context);
      Navigator.pushNamedAndRemoveUntil(context, OnBoardingView.routeName,(route) => false,);
      print("verifySmsCode");
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException");
      Navigator.pushReplacementNamed(context, ContinueAccountView.routeName);
      hideDialog(context);
      await userCredential?.user?.delete();
      await UsersDao.removeUser(userCredential!.user!.uid);
      showMessageWithSnackPar(message: e.message ?? e.code, context: context);
    }
  }
  Future<void> editNumberPhoneInFireStoreAfterEdit()async{
    await UsersDao.createUser(UserSocialModel(id: userCredential?.user?.uid, isAccountSocial: true, phoneNumber: phoneNumber));
  }
}