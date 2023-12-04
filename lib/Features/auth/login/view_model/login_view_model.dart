import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_application/Features/auth/login/navigator/login_navigator.dart';
import 'package:todo_list_application/core/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{
  bool isHidePassword = true;
  IconData eyePassword = Icons.remove_red_eye;

  Future<void> login(String email,String password)async{
    navigator.showLoading();
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      print("userCredential");
      navigator.hideDialogLoading();
      if(userCredential.user?.emailVerified == true){
        navigator.showMessageSnackPar(message: "Success");
      }else{
        navigator.showMessageSnackPar(message: "Please activate the account");
      }
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('user-not-found');
        navigator.hideDialogLoading();
        navigator.showMessageSnackPar(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print("wrong-password");
        navigator.hideDialogLoading();
        navigator.showMessageSnackPar(message: 'Wrong password provided for that user.');
      }
    }catch(e){
      navigator.hideDialogLoading();
      navigator.showMessageSnackPar(message: e.toString());
    }
  }
  Future<void>resetPassword({required String email})async{
    navigator.showLoading();
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      navigator.hideDialogLoading();
      navigator.showMessageSnackPar(message: "A message has been sent to your account to change the password please go and change the password");
    } on Exception catch (e) {
      navigator.hideDialogLoading();
      navigator.showMessageSnackPar(message: "This email is not valid, modify it");
    }
  }
  void onPressedSuffixIcon(){
    isHidePassword = !isHidePassword;
    eyePassword = isHidePassword == true
        ? Icons.remove_red_eye
        : Icons.remove_red_eye_outlined;
    notifyListeners();
  }
}