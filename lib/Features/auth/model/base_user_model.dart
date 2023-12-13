class BaseUserModel{
  String? id;
  String? phoneNumber;
  bool? isAccountSocial;
  BaseUserModel({required this.id,required this.isAccountSocial,required this.phoneNumber});
  BaseUserModel.fromFireStore(Map<String,dynamic> date){
    id = date['id'];
    isAccountSocial = date['isAccountSocial'];
    phoneNumber = date['phoneNumber'];
  }
  Map<String,dynamic>toFireStore(){
    return {
      "id":id,
      "phoneNumber":phoneNumber,
      "isAccountSocial":isAccountSocial,
    };
  }
}