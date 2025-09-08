/// A utility class for validating various types of input fields.
///
/// Supports validation for:
/// - PIN Code
/// - Bank Account Number
/// - IFSC Code
/// - Passwords
/// - Indian Mobile Number
/// - Aadhaar Number
/// - PAN
/// - GSTIN
/// - State, City, Name, Address, Shop Name, Email
class RegexValidator {
  /// Validates a 6-digit PIN Code.
  static bool isValidPinCode(String pin) {
    final RegExp regex = RegExp(r'^\d{6}$');
    return regex.hasMatch(pin);
  }

  /// Validates a bank account number (10-18 digits).
  static bool isValidBankAccount(String bankAccount) {
    final RegExp regex = RegExp(r'^\d{10,18}$');
    return regex.hasMatch(bankAccount);
  }

  /// Validates an IFSC code (format: XXXX0XXXXXX).
  static bool isValidIfsc(String ifsc) {
    final RegExp regex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
    return regex.hasMatch(ifsc);
  }

  /// Validates a password with at least 6 characters,
  /// including letters, numbers, and special characters (! $ @ %).
  static bool isValidPassword(String password) {
    final RegExp regex =
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!$@%])[A-Za-z\d!$@%]{6,}$');
    return regex.hasMatch(password);
  }

  /// Validates an Indian mobile number (10 digits, optional +91).
  static bool isValidIndianMobile(String mobile) {
    final RegExp regex =
    RegExp(r'^(?!.*(\d)\1{9})(\+91[\-\s]?)?[6-9]\d{9}$');
    return regex.hasMatch(mobile.trim());
  }

  /// Validates a 12-digit Aadhaar number (first digit 2-9).
  static bool isValidAadhaar(String aadhaar) {
    final RegExp regex = RegExp(r'^[2-9]{1}[0-9]{11}$');
    return regex.hasMatch(aadhaar.trim());
  }

  /// Validates a PAN number (format: ABCDE1234F).
  static bool isValidPan(String pan) {
    final RegExp regex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    return regex.hasMatch(pan.toUpperCase());
  }

  /// Validates a GSTIN number (Indian GST format).
  static bool isValidGstin(String gstin) {
    final RegExp regex =
    RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');
    return regex.hasMatch(gstin.toUpperCase());
  }

  /// Validates a state name (3-30 characters, letters and spaces only).
  static bool isValidStateName(String state) {
    final RegExp regex = RegExp(r"^[A-Za-z ]{3,30}$");
    return regex.hasMatch(state.trim());
  }

  /// Validates a name (2-40 characters, letters, spaces, apostrophes, hyphens allowed).
  static bool isValidName(String name) {
    final RegExp regex = RegExp(r"^[A-Za-z\s'-]{2,40}$");
    return regex.hasMatch(name.trim());
  }

  /// Validates a city name (2-40 characters, letters, spaces, hyphens allowed).
  static bool isValidCity(String city) {
    final RegExp regex = RegExp(r"^[a-zA-Z\s\-]{2,40}$");
    return regex.hasMatch(city.trim());
  }

  /// Validates an address (5-100 characters, letters, numbers, spaces, and certain symbols allowed).
  static bool isValidAddress(String address) {
    final RegExp regex = RegExp(r"^[A-Za-z0-9\s,./#-]{5,100}$");
    return regex.hasMatch(address.trim());
  }

  /// Validates a shop name (3-50 characters, letters, numbers, spaces, & , ' . - allowed).
  static bool isValidShopName(String name) {
    final RegExp regex = RegExp(r"^[A-Za-z0-9\s&',.-]{3,50}$");
    return regex.hasMatch(name.trim());
  }

  /// Validates an email address (standard email format).
  static bool isValidEmail(String email) {
    final RegExp regex =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email.trim());
  }
}
