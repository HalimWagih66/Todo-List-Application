import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_application/Features/auth/continue_account/navigator/continue_account_navigator.dart';
import 'package:twitter_login/twitter_login.dart';
import '../../../../core/base/base_view_model.dart';

class ContinueAccountViewModel extends BaseViewModel<ContinueAccountNavigator>{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final LoginResult loginFaceBookResult;
  late final UserCredential userCredential;

  Future<void> signInWithGoogle()async{
    navigator.showLoading();
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if(googleSignInAccount == null) {
      navigator.hideDialogLoading();
      return;
    }
    GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
    OAuthCredential authCredential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication?.idToken,accessToken: googleSignInAuthentication?.accessToken);
    await initializeUserCredential(authCredential);
  }


  Future<void> signOutFromGoogle()async{
    navigator.showLoading();
    await _googleSignIn.disconnect();
    navigator.hideDialogLoading();
    navigator.showMessageSnackPar(message: "Logout successfully");
  }
  Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    navigator.showLoading();
    loginFaceBookResult = await FacebookAuth.instance.login();
    if(loginFaceBookResult == null){
      navigator.hideDialogLoading();
      return;
    }
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginFaceBookResult.accessToken!.token);
    // Once signed in, return the UserCredential
    await initializeUserCredential(facebookAuthCredential);
  }

  Future<void> signInWithTwitter(BuildContext context) async {
    // Create a TwitterLogin instance
    navigator.showLoading();

    final twitterLogin = TwitterLogin(
        apiKey: '2BkJHOIaEU3bWnfYR5DI2alvg',
        apiSecretKey: '4nnxISnooCrSgerrdwOAhhMXOnLpeT8eSTWfxghPvf6c0DngT2',
        redirectURI: 'flutter-twitter-login://'
    );

    // Trigger the sign-in flow

    final authResult = await twitterLogin.login();

    if (authResult == null) {
      navigator.hideDialogLoading();
      return;
    }

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );
    await firebaseAuthSignInWithCredential(context,twitterAuthCredential);
  }


  Future<void>signOutFromTwitter()async{
    navigator.showMessageSnackPar(message: "Logout successfully");
    await FirebaseAuth.instance.signOut();
    print("sign out");
  }


  Future<void> firebaseAuthSignInWithCredential(BuildContext context,OAuthCredential oAuthCredential)async{
    try{
      await initializeUserCredential(oAuthCredential);
    } on FirebaseAuthException catch (e) {
      if(e.code == "account-exists-with-different-credential"){
        navigator.hideDialogLoading();
        navigator.showMessageSnackPar(message: AppLocalizations.of(context)!.the_account_already_exists_for_that_email);
      }else{
        navigator.hideDialogLoading();
        navigator.showMessageSnackPar(message: AppLocalizations.of(context)!.something_went_error);
      }
    } catch (e) {
      navigator.hideDialogLoading();
      navigator.showMessageSnackPar(message: e.toString());
    }
  }
  Future<void>initializeUserCredential(OAuthCredential oAuthCredential)async{
    userCredential = await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
    navigator.hideDialogLoading();
    navigator.showMessageSnackPar(message: "Welcome in Todo List ${userCredential.user?.displayName}");
  }
}