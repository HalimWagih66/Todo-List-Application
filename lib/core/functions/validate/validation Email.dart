class ValidationEmail{
  static bool isEmail(String email) {

    String regex = (r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    RegExp regExp = RegExp(regex);

    return regExp.hasMatch(email);
  }
}