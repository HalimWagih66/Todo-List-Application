import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/Features/auth/login/navigator/login_navigator.dart';
import 'package:todo_list_application/Features/auth/login/view/widget/customFieldPassword.dart';
import 'package:todo_list_application/Features/auth/login/view_model/login_view_model.dart';
import 'package:todo_list_application/Features/auth/sign_up/presentation/view/widget/custom_leading_item.dart';
import 'package:todo_list_application/core/base/base_state.dart';
import '../../../../core/functions/validate/validation Email.dart';
import '../../../../core/widget/TextFormField/custom_form_field.dart';
import '../../continue_account_with_email/view/continue_with_email_view.dart';

class LoginView extends StatefulWidget {
   const LoginView({super.key});
  static const routeName = "LoginView";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView,LoginViewModel>implements LoginNavigator{

   var formKey = GlobalKey<FormState>();


  TextEditingController emailController = TextEditingController(text: 'halemwagih6@gmail.com');

  TextEditingController passwordController = TextEditingController(text: "112233qq");
   @override
   void dispose() {
     passwordController.dispose();
     emailController.dispose();
     super.dispose();
   }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
          decoration: const BoxDecoration(
              color: Color(0xffF2F5FF),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xffe9e4f0),
                  Color(0xff5c76ff),
                  Color(0xff4863eb),
              Color(0xff617afd),
            ]
            )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: CustomLeadingItem(colorIcon: Colors.white,onPressed: (){
                Navigator.pushReplacementNamed(context, ContinueAccountWithEmailView.routeName,result:  (route) => false);
              }),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(AppLocalizations.of(context)!.login,),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.13,
                      ),
                      Card(
                        color: const Color(0xfff1f1f1),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(AppLocalizations.of(context)!.welcome_back,
                                    style: Theme.of(context).textTheme.titleLarge,textAlign: TextAlign.start,),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.04,
                              ),
                              CustomFormField(
                                hintText: "ex: jon.smith@email.com",
                                textLabel: AppLocalizations.of(context)!.email_address,
                                inputField: emailController,
                                functionValidate: (text) {
                                  if (text?.isEmpty == true ||
                                      text?.trim().isEmpty == true) {
                                    return AppLocalizations.of(context)!.please_enter_email_address;
                                  }
                                  if (!ValidationEmail.isEmail(text!)) {
                                    return AppLocalizations.of(context)!.please_enter_the_email_correctly;
                                  }
                                },
                                borderField: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        style: BorderStyle.solid,
                                        width: 2)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomFieldPassword(passwordController: passwordController),
                              TextButton(
                                onPressed: () {
                                  if(emailController.text.isEmpty){
                                    showMessageSnackPar(message: "Please enter your email");
                                  }else{
                                    viewModel.resetPassword(email: emailController.text);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: Text("Forget Password?",style: Theme.of(context).textTheme.displaySmall?.copyWith(letterSpacing: 1.2,fontWeight: FontWeight.normal)),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async{
                                  if (formKey.currentState?.validate() == false) return;
                                  viewModel.login(emailController.text, passwordController.text);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 20, horizontal: 33),
                                  backgroundColor: const Color(0xfff6f8fd),
                                  elevation: 25,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(AppLocalizations.of(context)!.login,
                                        style:Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: 1.2)),
                                    const Icon(Icons.arrow_forward_ios_rounded,
                                        color: Colors.grey),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }
  Future<void>login()async{
      await viewModel.login(emailController.text, passwordController.text);
  }
}
