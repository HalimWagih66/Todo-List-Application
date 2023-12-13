import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_application/Features/auth/login/navigator/login_navigator.dart';
import 'package:todo_list_application/Features/onboarding/view/using_app_view.dart';
import 'package:todo_list_application/core/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{
  bool isHidePassword = true;
  IconData eyePassword = Icons.remove_red_eye;

  Future<void> login(String email,String password)async {
    navigator.showLoading();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email,
          password: password
      );
      navigator.navigatorPop();
      if (userCredential.user?.emailVerified == true) {
        navigator.pushScreenAndRemoveUntil(routeName: OnBoardingView.routeName);
      } else {
        navigator.showMessageSnackPar(message: "Please activate the account");
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if(e.code == "invalid-credential"){
        navigator.navigatorPop();
        navigator.showMessageSnackPar(message: "There is an error in the email or password");
      }
      else{
        navigator.navigatorPop();
        navigator.showMessageSnackPar(message: e.message??e.code);
      }
    } catch(e){
      navigator.navigatorPop();
      navigator.showMessageSnackPar(message: e.toString());
    }
  }
  Future<void>resetPassword({required String email})async{
    navigator.showLoading();
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      navigator.navigatorPop();
      navigator.showMessageSnackPar(message: "A message has been sent to your account to change the password please go and change the password");
    } on Exception catch (_) {
      navigator.navigatorPop();
      navigator.showMessageSnackPar(message: "This email is not valid, modify it");
    }
  }
  Future<void>logout()async{
    navigator.showLoading();
    await FirebaseAuth.instance.signOut();
    navigator.navigatorPop();
  }
  void onPressedSuffixIcon(){
    isHidePassword = !isHidePassword;
    eyePassword = isHidePassword == true
        ? Icons.remove_red_eye
        : Icons.remove_red_eye_outlined;
    notifyListeners();
  }
}