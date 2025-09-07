class RegexValidator {
  static bool isValidPinCode(String pin) {
    final RegExp regex = RegExp(r'^\d{6}$');
    return regex.hasMatch(pin);
  }

  static bool isValidBankAccount(String bankAccount) {
    final RegExp regex = RegExp(r'^\d{10,18}$');
    return regex.hasMatch(bankAccount);
  }

  static bool isValidIfsc(String ifsc) {
    final RegExp regex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
    return regex.hasMatch(ifsc);
  }

  static bool isValidPassword(String password) {
    final RegExp regex =
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!$@%])[A-Za-z\d!$@%]{6,}$');
    return regex.hasMatch(password);
  }

  static bool isValidIndianMobile(String mobile) {
    final RegExp regex = RegExp(
        r'^(?!.*(\d)\1{9})(\+91[\-\s]?)?[6-9]\d{9}$'
    );
    return regex.hasMatch(mobile.trim());
  }



  static bool isValidAadhaar(String aadhaar) {
    final RegExp regex = RegExp(r'^[2-9]{1}[0-9]{11}$');
    return regex.hasMatch(aadhaar.trim());
  }

  static bool isValidPan(String pan) {
    final RegExp regex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    return regex.hasMatch(pan.toUpperCase());
  }

  static bool isValidGstin(String gstin) {
    final RegExp regex =
    RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');
    return regex.hasMatch(gstin.toUpperCase());
  }

  static bool isValidStateName(String state) {
    final RegExp regex = RegExp(r"^[A-Za-z ]{3,30}$");
    return regex.hasMatch(state.trim());
  }

  static bool isValidName(String name) {
    final RegExp regex = RegExp(r"^[A-Za-z\s'-]{2,40}$");
    return regex.hasMatch(name.trim());
  }

  static bool isValidCity(String city) {
    final RegExp regex = RegExp(r"^[a-zA-Z\s\-]{2,40}$");
    return regex.hasMatch(city.trim());
  }


  static  bool isValidAddress(String address) {
    final RegExp regex = RegExp(r"^[A-Za-z0-9\s,./#-]{5,100}$");
    return regex.hasMatch(address.trim());
  }
  static bool isValidShopName(String name) {
    final RegExp regex = RegExp(r"^[A-Za-z0-9\s&',.-]{3,50}$");
    return regex.hasMatch(name.trim());
  }
  static bool isValidEmail(String email) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email.trim());
  }


}
