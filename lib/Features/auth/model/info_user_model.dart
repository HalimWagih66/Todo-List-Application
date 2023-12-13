import 'package:todo_list_application/Features/auth/model/base_user_model.dart';

class InformationUserModel extends BaseUserModel{
  String? fullName;
  static const collectionName = "users";
  String? email;
  String? pathImage;
  InformationUserModel({ this.fullName, this.email, super.id,super.phoneNumber,this.pathImage,super.isAccountSocial});
  InformationUserModel.formFireStore(Map<String,dynamic>?data):this(
    pathImage: data?['pathImage'],
    email: data?['email'],
    id: data?['id'],
    isAccountSocial: data?['isAccountSocial'],
    fullName: data?['name'],
    phoneNumber: data?["phone"],
  );
  @override
  Map<String,dynamic>toFireStore(){
    return {
     "name":fullName,
      "pathImage":pathImage,
      "phone":phoneNumber,
      "email":email,
      "id":id,
      "isAccountSocial":isAccountSocial,
    };
  }

  @override
  String toString() {
    return 'InformationUserModel{fullName: $fullName, email: $email, phoneNumber: $phoneNumber, pathImage: $pathImage}';
  }
}