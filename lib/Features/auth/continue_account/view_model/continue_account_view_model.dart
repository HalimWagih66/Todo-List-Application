import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_application/Features/auth/Dao/users_dao.dart';
import 'package:todo_list_application/Features/auth/continue_account/navigator/continue_account_navigator.dart';
import 'package:todo_list_application/Features/auth/model/base_user_model.dart';
import 'package:todo_list_application/Features/home%20layout/view/home_layout_view.dart';
import 'package:twitter_login/twitter_login.dart';
import '../../../../core/base/base_view_model.dart';
import '../../model/user_social_model.dart';

class ContinueAccountViewModel extends BaseViewModel<ContinueAccountNavigator> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final LoginResult loginFaceBookResult;
  PageController pageController = PageController();
  late UserCredential userCredential;
  BuildContext? context;
  Future<void> signInWithGoogle() async {
    navigator.showLoading();
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      navigator.navigatorPop();
      return;
    }
    GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
    OAuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);
    await firebaseAuthSignInWithCredential(authCredential);
  }

  Future<void> signOutFromGoogle() async {
    navigator.showLoading();
    await _googleSignIn.disconnect();
    navigator.navigatorPop();
    navigator.showMessageSnackPar(message: "Logout successfully");
  }

  Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    navigator.showLoading();
    loginFaceBookResult = await FacebookAuth.instance.login();
    if (loginFaceBookResult == null) {
      navigator.navigatorPop();
      return;
    }
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginFaceBookResult.accessToken!.token);
    // Once signed in, return the UserCredential
    await firebaseAuthSignInWithCredential(facebookAuthCredential);
  }

  Future<void> signInWithTwitter(BuildContext context) async {
    // Create a TwitterLogin instance
    navigator.showLoading();

    final twitterLogin = TwitterLogin(
        apiKey: '2BkJHOIaEU3bWnfYR5DI2alvg',
        apiSecretKey: '4nnxISnooCrSgerrdwOAhhMXOnLpeT8eSTWfxghPvf6c0DngT2',
        redirectURI: 'flutter-twitter-login://');

    // Trigger the sign-in flow

    final authResult = await twitterLogin.login();

    if (authResult == null) {
      navigator.navigatorPop();
      return;
    }

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );
    await firebaseAuthSignInWithCredential(twitterAuthCredential);
  }

  Future<void> signOutFromTwitter() async {
    navigator.showMessageSnackPar(message: "Logout successfully");
    await FirebaseAuth.instance.signOut();
    print("sign out");
  }

  Future<void> firebaseAuthSignInWithCredential(OAuthCredential oAuthCredential) async {
    try {
      await initializeUserCredential(oAuthCredential);
      navigator.initializeInformationUserModel(userCredential);
      navigator.connectEditPhoneNumber();
      BaseUserModel? baseUserModel = await UsersDao.getUser(userCredential.user!.uid);
      if(baseUserModel == null){
        await casePhoneNumberUserEqualNull();
      }else{
        await casePhoneNumberUserIsNotEqualNull();
      }
    } on FirebaseAuthException catch (e) {
      navigator.navigatorPop();
      if (e.code == "account-exists-with-different-credential") {
        navigator.showMessageSnackPar(
            message: AppLocalizations.of(context!)!
                .the_account_already_exists_for_that_email);
      } else {
        navigator.navigatorPop();
        navigator.showMessageSnackPar(
            message: AppLocalizations.of(context!)!.something_went_error);
      }
      print("FirebaseAuthException = $e");
      await userCredential.user?.delete();
      await UsersDao.removeUser(userCredential.user!.uid);
    } catch (e) {
      navigator.navigatorPop();
      if(e.toString() == "'package:flutter/src/widgets/scroll_controller.dart': Failed assertion: line 157 pos 12: '_positions.isNotEmpty': ScrollController not attached to any scroll views."){
        return;
      }
      print("catch e = ${e.toString()}");
      await userCredential.user?.delete();
      await UsersDao.removeUser(userCredential.user!.uid);
      navigator.navigatorPop();
      navigator.showMessageSnackPar(message: e.toString());
    }
  }

  Future<void>casePhoneNumberUserEqualNull()async{
    await insertUserInFireStore(userCredential.user!.uid);
    navigator.navigatorPop();
    navigator.pushScreenSignUpAndRemoveUntil();
  }
  Future<void>casePhoneNumberUserIsNotEqualNull()async{
    navigator.pushScreenAndRemoveUntil(routeName: HomeLayout.routeName);
  }
  Future<void>initializeUserCredential(OAuthCredential oAuthCredential)async{
    userCredential = await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
  }
  Future<void>insertUserInFireStore(String uId)async{
    await UsersDao.createUser(
        UserSocialModel(
            id: uId,
            isAccountSocial: true,
            phoneNumber: userCredential.user?.phoneNumber
        )
    );
  }
}