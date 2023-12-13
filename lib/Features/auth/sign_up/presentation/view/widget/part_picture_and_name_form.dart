import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/widget/TextFormField/custom_form_field.dart';
import '../../../../../../core/widget/dialogs/show_dialog_upload_image.dart';
import '../../view_model/sign_up_view_model.dart';
import 'custom_icon_navigate_between_pages.dart';
import 'custom_pick_image.dart';

class PartPictureAndNameForm extends StatelessWidget {
  PartPictureAndNameForm({super.key, required this.firstNameController, required this.lastNameController});

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? pickedImage;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                await showUploadImage(context);
              },
              child: const CustomPickImage(),
              ),
            const SizedBox(height: 30),
            CustomFormField(
              hintText: "ex: smith",
              textLabel: AppLocalizations.of(context)!.first_name,
              inputField: firstNameController,
              functionValidate: (text) {
                print("functionValidate");
                if (text == null || text.trim().isEmpty == true) {
                  return AppLocalizations.of(context)!.please_enter_your_name;
                }else if(text.contains(" ") == true){
                  return AppLocalizations.of(context)!.please_enter_your_first_name_only;
                }
              },
              borderField: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue, style: BorderStyle.solid, width: 2)),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomFormField(
              hintText: "ex: Smith",
              textLabel: AppLocalizations.of(context)!.last_name,
              inputField: lastNameController,
              functionValidate: (text) {
                if (text == null || text.trim().isEmpty == true) {
                  return AppLocalizations.of(context)!.please_enter_your_name;
                }
                if(text.contains(" ") == true){
                  return AppLocalizations.of(context)!.please_enter_your_first_name_only;
                }
              },
              borderField: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue, style: BorderStyle.solid, width: 2)),
            ),
            CustomIconNavigateBetweenPages(onPressed: ()async{
              await onPressedCustomIconNext(context);
            },
              iconData: Icons.navigate_next,
            )
          ],
        ),
    );
  }
  Future<void> onPressedCustomIconNext(BuildContext context)async{
    var signUpViewModel = Provider.of<SignUpViewModel>(context, listen: false);
    if (formKey.currentState?.validate() != true) return;
    if(signUpViewModel.pickedImage == null){
      signUpViewModel.navigator.showMessageSnackPar(message: "Please Upload Your Image");
      return;
    }
    //await signUpViewModel.uploadImage();
    signUpViewModel.navigator.controlPageViewBuilder(1);
    signUpViewModel.fullName = "${firstNameController.text} ${lastNameController.text}" ;
  }
  Future<void> showUploadImage(BuildContext context) async {
    var signUpViewModel = Provider.of<SignUpViewModel>(context,listen: false);
    await showDialogUploadImage(
        context: context,
        onPressedCamera: () async {
          await signUpViewModel.onPressedCamera();
        },
        onPressedGallery: () async {
          await signUpViewModel.onPressedGallery();
        });
  }
}
