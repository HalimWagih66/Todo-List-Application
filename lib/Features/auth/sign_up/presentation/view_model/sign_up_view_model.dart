import 'dart:async';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/Features/auth/Dao/users_dao.dart';
import 'package:todo_list_application/Features/auth/login/view/login_view.dart';
import 'package:todo_list_application/core/base/base_navigator.dart';
import 'package:todo_list_application/provider/user_information_provider.dart';
import '../../../../../core/base/base_view_model.dart';
import '../../../../../core/functions/image picker/image_picker_functions.dart';
import '../../../continue_account/view/continue_account_view.dart';
import '../../../model/info_user_model.dart';

abstract class SignUpNavigator extends BaseNavigator {
  void controlPageViewBuilder(int pageNumber);
  void pushReplacementSignUp();
}

class SignUpViewModel extends BaseViewModel<SignUpNavigator> {
  bool isHidePassword = true;
  IconData eyePassword = Icons.remove_red_eye;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  File? pickedImage;
  ConfirmationResult? confirmationResult;
  bool isPhoneNumberValid = false;
  String? verificationId;
  String? urlDownloader;
  PhoneNumber? phoneNumber;
  PageController pageController = PageController();
  String? email;
  String? fullName;
  int? selectedPage;
  bool isSuccessRegister = false;
  String? password;
  bool isFirstPage = true;
  UserCredential? userCredential;
  Future<void> createAccount(BuildContext context) async {
    navigator.showLoading();
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      await verifyPhoneNumber(userCredential: userCredential!);
      initializeUserEmailAndPasswordModel(context);
      isSuccessRegister = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.navigatorPop();
        navigator.controlPageViewBuilder(1);
        navigator.showMessageSnackPar(
            message: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        navigator.navigatorPop();
        navigator.showMessageSnackPar(
            message: "The account already exists for that email.");
      }
    } catch (e) {
      navigator.navigatorPop();
      navigator.showMessageAwesome(
          message: e.toString(), dialogType: DialogType.error);
    }
  }

  void changePageViewBuilder(int value) {
    if (value == 1) {
      isFirstPage = false;
      notifyListeners();
    }
  }

  void initializeUserEmailAndPasswordModel(BuildContext context) {
    Provider.of<UserInformationProvider>(context, listen: false).informationUserModel =
        InformationUserModel(
            fullName: fullName,
            phoneNumber: phoneNumber?.completeNumber,
            email: email,
            isAccountSocial: false,
            pathImage: urlDownloader);

    print(Provider.of<UserInformationProvider>(context, listen: false).informationUserModel.id);
  }

  Future<void> insertUserInFireStore() async {
    await UsersDao.createUser(InformationUserModel(
      pathImage: urlDownloader,
      isAccountSocial: false,
      fullName: fullName,
      email: userCredential?.user?.email,
      id: userCredential?.user?.uid,
      phoneNumber: phoneNumber?.completeNumber,
    ));
  }
  void onPressedSuffixIcon() {
    isHidePassword = !isHidePassword;
    eyePassword = isHidePassword == true
        ? Icons.remove_red_eye
        : Icons.remove_red_eye_outlined;
    notifyListeners();
  }

  Future<void> verifyPhoneNumber({bool isResendSms = false,required UserCredential userCredential}) async {
    if (isResendSms) {
      navigator.showLoading();
    }
    print("verifyPhoneNumber ${phoneNumber?.completeNumber}");
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber?.completeNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        print("verificationCompleted");
      },
      verificationFailed: (FirebaseAuthException e) async{
        await verificationFailedVerifyPhoneNumber(e,userCredential);
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSentVerifyPhoneNumber(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verificationFailedVerifyPhoneNumber(FirebaseAuthException e,UserCredential userCredential) async{
    await UsersDao.removeUser(userCredential!.user!.uid);
    await userCredential?.user?.delete();
    navigator.navigatorPop();
    navigator.pushScreenAndRemoveUntil(routeName: ContinueAccountView.routeName);
    navigator.showMessageAwesome(
        message: e.message ?? e.code,
        dialogType: DialogType.error,
        title: "ERROR",
        nigActionName: "Cancel",
        nigAction: () {});
    print("verificationFailed");
  }

  void codeSentVerifyPhoneNumber(String verificationId) {
    print("codeSent");
    navigator.navigatorPop();
    this.verificationId = verificationId;
    navigator.controlPageViewBuilder(3);
    print("codeSent");
  }

  void changePickImage(File pickImage) {
    pickedImage = pickImage;
    notifyListeners();
  }

  Future<void> verifySmsCode(String smsCode) async {
    navigator.showLoading();
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!, smsCode: smsCode);
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      await firebaseAuth.signInWithCredential(credential);
      await uploadImageInFirebaseStorage();
      await insertUserInFireStore();
      navigator.navigatorPop();
      navigator.showMessageAwesome(
          title: "Success",
          dialogType: DialogType.success,
          message:
              "Your data has been entered correctly dear nothing is missing Account activation We have sent a message to your account to activate the account and then try to log in",
          posActionName: "Ok",
          posAction: () {
            navigator.pushScreenAndRemoveUntil(routeName: LoginView.routeName);
          });
      print("verifySmsCode");
    } on FirebaseAuthException catch (e) {
      await caseEventException(e.message ?? e.code);
    }catch (e){
      await caseEventException(e.toString());
    }
  }
  Future<void>caseEventException(String message)async{
    print("FirebaseAuthException");
    navigator.navigatorPop();
    await userCredential?.user?.delete();
    await UsersDao.removeUser(userCredential!.user!.uid);
    navigator.pushScreenAndRemoveUntil(routeName: ContinueAccountView.routeName);
    navigator.showMessageSnackPar(message:message);
  }
  String? validatorPhoneNumberInput() {
    if (!isPhoneNumberValid) {
      return "Invalid phone number.";
    }
    return null;
  }

  void onInputValidatedPhoneNumberInput(bool isValid) {
    if (isValid == true) {
      print("onInputValidated $isValid");
      isPhoneNumberValid = true;
    } else {
      print("onInputValidated $isValid");
      isPhoneNumberValid = false;
    }
  }

  void onInputChangedPhoneNumberInput(PhoneNumber number) {
    print("phone no completeNumber = ${phoneNumber?.completeNumber}");
    if (isPhoneNumberValid) {
      phoneNumber = number!;
      print("phone provider = $phoneNumber");
      print("phone completeNumber = ${phoneNumber?.completeNumber}");
    }
  }

  Future<void> onPressedCamera() async {
    var tempPickedImage = await ImagePackerFunctions.cameraPicker();
    if (tempPickedImage != null) {
      changePickImage(tempPickedImage);
    }
    navigator.navigatorPop();
  }

  Future<void> onPressedGallery() async {
    File? tempPickedImage = await ImagePackerFunctions.galleryPicker();
    if (tempPickedImage != null) {
      changePickImage(tempPickedImage);
    }
    navigator.navigatorPop();
  }

  Future<void> uploadImageInFirebaseStorage() async {
    print("uploadImage");
    try {
      FirebaseStorage firebaseStorage = FirebaseStorage.instanceFor(
          bucket: "gs://todo-list-7eddb.appspot.com");
      Reference reference = firebaseStorage.ref().child(pathImage());
      UploadTask uploadTask = reference.putFile(pickedImage!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      urlDownloader = await taskSnapshot.ref.getDownloadURL();
      print("urlDownloader = $urlDownloader");
    } on FirebaseException catch (e) {
      navigator.showMessageSnackPar(message: e.message ?? e.code);
    } catch (e) {
      navigator.showMessageSnackPar(message: e.toString());
    }
  }

  String pathImage() {
    return p.basename(pickedImage!.path).replaceRange(
          0,
          p.basename(pickedImage!.path).lastIndexOf('.'),
          email!.substring(
            0,
            email!.lastIndexOf("."),
          ),
        );
  }
}
