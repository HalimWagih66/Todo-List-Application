import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_application/Features/auth/continue_account_with_email/view/continue_with_email_view.dart';
import 'package:todo_list_application/Features/auth/sign_up/presentation/view/widget/custom_leading_item.dart';
import 'package:todo_list_application/Features/auth/sign_up/presentation/view/widget/edit_phone_number.dart';
import 'package:todo_list_application/Features/auth/sign_up/presentation/view/widget/otp_page.dart';
import 'package:todo_list_application/Features/auth/sign_up/presentation/view/widget/part_email_and_phone_form.dart';
import 'package:todo_list_application/Features/auth/sign_up/presentation/view/widget/part_password_form.dart';
import 'package:todo_list_application/Features/auth/sign_up/presentation/view/widget/part_picture_and_name_form.dart';
import 'package:todo_list_application/core/base/base_state.dart';
import 'package:todo_list_application/core/style/colors/application_color.dart';
import '../view_model/sign_up_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key, this.selectedPage});
  final int? selectedPage;
  static const String routeName = "SignUpView";

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends BaseState<SignUpView, SignUpViewModel>
    implements SignUpNavigator {
  TextEditingController fullNameController =
      TextEditingController(text: "halim");

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController emailController =
      TextEditingController(text: "halemwagih6@gmail.com");

  TextEditingController passwordController =
      TextEditingController(text: "112233qq");
  TextEditingController lastNameController =
      TextEditingController(text: "Wagih");

  TextEditingController passwordConfirmationController =
      TextEditingController(text: "112233qq");
  final pinController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    passwordConfirmationController.dispose();
    fullNameController.dispose();
    //viewModel.pageController.dispose();
    emailController.dispose();
    pinController.dispose();
    super.dispose();
  }
  late int timp;

  List<Widget> formFragments = [];

  @override
  void initState() {
    formFragments = [
      PartPictureAndNameForm(
          firstNameController: fullNameController,
          lastNameController: lastNameController),
      PartPasswordForm(
          passwordController: passwordController,
          passwordConfirmationController: passwordConfirmationController),
      PartEmailAndPasswordForm(
          emailController: emailController,
          phoneNumberController: phoneNumberController),
      OtpPage(pinController: pinController),
      EditPhoneNumber(phoneNumberController: phoneNumberController)
    ];
    super.initState();
    viewModel.selectedPage = widget.selectedPage;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xfff7f3f3),
                  Color(0xff6079ff),
                  Color(0xff4863eb),
                  Color(0xff5772ff),
                ]
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("Sign Up"),
            backgroundColor: Colors.transparent,
            leading: CustomLeadingItem(
                colorIcon:
                    viewModel.isFirstPage ? Colors.white : Colors.transparent,
                onPressed: () {
                  if(viewModel.isFirstPage == false)return;
                  pushScreenAndRemoveUntil(routeName: ContinueAccountWithEmailView.routeName);
                }),
          ),
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    decoration:const BoxDecoration(
                      color: Color(0xfffdfdfd),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      border: Border(
                        left: BorderSide(width: 7,style: BorderStyle.solid,color: primaryColor),
                        bottom: BorderSide(width: 10,style: BorderStyle.solid,color: primaryColor),
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      child: Transform.translate(
                        offset: const Offset(0, -50),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: PageView.builder(
                            controller: viewModel.pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: formFragments.length,
                            itemBuilder: (BuildContext context, int index) {
                              return formFragments[selectedPagePageViewBuilder(index)];
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  int selectedPagePageViewBuilder(int index){
    if(viewModel.selectedPage != null) {
      return viewModel.selectedPage!;
    } else{
      return index;
    }
  }

  @override
  SignUpViewModel initViewModel() {
    return SignUpViewModel();
  }

  @override
  void controlPageViewBuilder(int numberPage) {
    viewModel.selectedPage = numberPage;
    viewModel.pageController.animateToPage(
      numberPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutSine,
    );
  }

  @override
  void pushReplacementSignUp() {
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const SignUpView(selectedPage: 4),) , (route) => false);
  }
}
