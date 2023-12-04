import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/Features/auth/login/navigator/login_navigator.dart';
import 'package:todo_list_application/Features/auth/login/view/widget/customFieldPassword.dart';
import 'package:todo_list_application/Features/auth/login/view_model/login_view_model.dart';
import 'package:todo_list_application/Features/auth/sign_up/view/sign_up_view.dart';
import 'package:todo_list_application/core/base/base_state.dart';
import '../../../../core/functions/validate/validation Email.dart';
import '../../../../core/widget/TextFormField/custom_form_field.dart';

class LoginView extends StatefulWidget {
   const LoginView({super.key});
  static const routeName = "LoginView";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView,LoginViewModel>implements LoginNavigator{

   var formKey = GlobalKey<FormState>();


  TextEditingController emailController = TextEditingController(text: 'halemwagih6@gmail.com');

  TextEditingController passwordController = TextEditingController(text: "have@gmail.com12345678");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
          decoration: const BoxDecoration(
              color: Color(0xffF2F5FF),
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/auth/background_auth.png"),
                fit: BoxFit.fill,
              )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(AppLocalizations.of(context)!.login),
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
                        color: Colors.white,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(AppLocalizations.of(context)!.welcome_back,
                                    style: Theme.of(context).textTheme.titleLarge,textAlign: TextAlign.start,),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.04,
                              ),
                              CustomFormField(
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
                                prefixIcon: Icons.email,
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
                                  await viewModel.login(emailController.text, passwordController.text);
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
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: GestureDetector(
                                    onTap: () {
                                      viewModel.goToScreenAndRemoveUntil(SignUpView.routeName);
                                    },
                                    child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!.i_don_t_have_an_account,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.blue),
                                        ),),),
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
