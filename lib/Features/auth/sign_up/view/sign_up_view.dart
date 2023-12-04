import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/Features/auth/login/view/login_view.dart';
import 'package:todo_list_application/Features/auth/sign_up/view/widget/customFieldPasswordSignUp.dart';
import 'package:todo_list_application/Features/auth/sign_up/view_model/sign_up_view_model.dart';
import 'package:todo_list_application/core/base/base_state.dart';
import '../../../../core/functions/validate/validation Email.dart';
import '../../../../core/widget/TextFormField/custom_form_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  static const String routeName = "SignUpView";

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends BaseState<SignUpView, SignUpViewModel>
    implements SignUpNavigator {


  TextEditingController fullNameController =
      TextEditingController(text: "have a good");

  TextEditingController emailController =
      TextEditingController(text: "halemwagih6@gmail.com");

  TextEditingController passwordController =
      TextEditingController(text: "have@gmail.com12345678");

  TextEditingController passwordConfirmationController =
      TextEditingController(text: "have@gmail.com12345678");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ( context) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
            color: Color(0xffF2F5FF),
            image: DecorationImage(
              image: AssetImage("assets/images/auth/background_auth.png"),
              fit: BoxFit.fill,
            )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
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
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 8),
                        child: Column(
                          children: [
                            CustomFormField(
                              textLabel: AppLocalizations.of(context)!.full_name,
                              inputField: fullNameController,
                              functionValidate: (text) {
                                if (text == null || text.trim().isEmpty == true) {
                                  return AppLocalizations.of(context)!
                                      .please_enter_your_name;
                                }
                                if (text.contains(" ") == false) {
                                  return AppLocalizations.of(context)!
                                      .please_enter_at_least_the_binary_name;
                                }
                              },
                              borderField: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue,
                                      style: BorderStyle.solid,
                                      width: 2)),
                              prefixIcon: Icons.person,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomFormField(
                              textLabel:
                                  AppLocalizations.of(context)!.email_address,
                              inputField: emailController,
                              functionValidate: (text) {
                                if (text?.isEmpty == true ||
                                    text?.trim().isEmpty == true) {
                                  return AppLocalizations.of(context)!
                                      .please_enter_email_address;
                                }
                                if (!ValidationEmail.isEmail(text!)) {
                                  return AppLocalizations.of(context)!
                                      .please_enter_the_email_correctly;
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
                            CustomFieldPasswordSignUp(controller: passwordController),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomFieldPasswordSignUp(controller: passwordConfirmationController,checkMatchPassword: true,firstPassword: passwordController.text),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .05,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.93,
                              child: ElevatedButton(
                                onPressed: ()async {
                                  await signUp();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 24),
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!
                                            .create_account,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              child: GestureDetector(
                                onTap: () {
                                  viewModel.goToScreenAndRemoveUntil(
                                      LoginView.routeName);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .i_already_have_an_account,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        color:  Colors.blue,
                                      ),
                                ),
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
  SignUpViewModel initViewModel() {
    return SignUpViewModel();
  }

  Future<void> signUp() async {
    if (formKey.currentState?.validate() == false) return;
    await viewModel.createAccount(
        fullNameController.text, emailController.text, passwordController.text);
  }
}
