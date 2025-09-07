import 'package:custom_text_form_field_initial_value/regax_validator.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';

class CustomTextFormField_initialvalue extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? minLength;
  final int? maxLength;
  final String? isMatched;
  final bool hasMatched;
  final bool isAadhaar;
  final bool isPan;
  final bool isBankAccount;
  final bool isIfsc;
  final bool isPassword;
  final bool isMobileNo;
  final bool isGstin; // ✅ New parameter
  final VoidCallback? onTap; // 👈 Add this
  bool showLoader ;
  bool bankVerified ;
  bool bankFailed ;
  bool isPinCode;
  bool isState;
  bool isName;
  bool isAddress;
  bool isShopName;
  bool isCity;




  CustomTextFormField_initialvalue({
    Key? key,
    this.controller,
    this.initialValue,
    required this.hintText,
    required this.keyboardType,
    this.obscureText = false,
    this.minLength,
    this.maxLength,
    this.isMatched,
    this.hasMatched = false,
    this.isAadhaar = false,
    this.isPan = false,
    this.isBankAccount = false,
    this.isIfsc = false,
    this.isPassword = false, // ✅ Default value
    this.isMobileNo = false, // ✅ Add this
    this.isGstin = false,
    this.onTap,
    this.showLoader = false,
    this.bankVerified = false,
    this.bankFailed = false,
    this.isPinCode = false,
    this.isState = false,
    this.isName = false,
    this.isAddress = false,
    this.isShopName = false,
    this.isCity = false


  }) : super(key: key);

  @override
  State<CustomTextFormField_initialvalue> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField_initialvalue> {
  bool _obscurePassword = true; // 👁️ For toggling password visibility


  @override
  void dispose() {
    if (widget.controller == null) {
      widget.controller?.dispose();
    }
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {
    if (widget.controller != null &&
        widget.initialValue != null &&
        widget.controller!.text.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.controller!.text = widget.initialValue!;
      });
    }

    return TextFormField(
      onTap: widget.onTap, // 👈 This line adds the optional onTap functionality

      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscurePassword : widget.obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColor.hintColor,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.boderColor),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.boderColor),
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.boderColor),
          borderRadius: BorderRadius.circular(16.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(16.0),
        ),
        // 👁️ Show eye icon only if it's a password field
        suffixIcon: SuffixIconBuilder.build(
          context: context,
          isPassword: widget.isPassword,
          isBank: widget.isBankAccount,
          showLoader: widget.showLoader,
          isVerified: widget.bankVerified,
          isFailed: widget.bankFailed,
          obscurePassword: _obscurePassword,
          toggleObscure: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),

      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a ${widget.hintText.toLowerCase()}';
        }

        String sanitizedValue = value.replaceAll(' ', '');
        if (widget.isMobileNo && !RegexValidator.isValidIndianMobile(sanitizedValue)) {
          return 'Enter a valid 10-digit mobile number';
        }

        if (widget.isBankAccount && !RegexValidator.isValidBankAccount(sanitizedValue)) {
          return 'Invalid Bank Account Number. It should be between 9 and 18 digits.';
        }

        if (widget.isIfsc && !RegexValidator.isValidIfsc(sanitizedValue)) {
          return 'Invalid IFSC Code. Format should be: XXXX0XXXXXX';
        }

        if (widget.hasMatched &&
            widget.isMatched != null &&
            widget.isMatched != sanitizedValue) {
          return 'Bank Account numbers do not match';
        }

        if (widget.isPassword && !RegexValidator.isValidPassword(sanitizedValue)) {
          return 'Password must be at least 6 characters and include numbers, letters, and special characters (!\$@%)';
        }
        if (widget.isAadhaar && !RegexValidator.isValidAadhaar(sanitizedValue)) {
          return 'Enter a valid 12-digit Aadhaar number';
        }
        if (widget.isPan && !RegexValidator.isValidPan(sanitizedValue)) {
          return 'Invalid PAN number';
        }
        if (widget.isGstin && !RegexValidator.isValidGstin(sanitizedValue)) {
          return 'Invalid GSTIN';
        }

        if (widget.isPinCode && !RegexValidator.isValidPinCode(sanitizedValue)) {
          return 'Invalid PIN Code. It should be exactly 6 digits.';
        }
        if (widget.isState) {
          final RegExp stateRegex = RegExp(r"^[A-Za-z ]{3,30}$");
          if (!stateRegex.hasMatch(sanitizedValue)) {
            return 'Enter a valid state name ';
          }
        }
        if (widget.isName && !RegexValidator.isValidName(sanitizedValue)) {
          return 'Enter a valid name ';
        }
        if (widget.isAddress && !RegexValidator.isValidAddress(sanitizedValue)) {
          return 'Enter a valid address';
        }
        if (widget.isShopName && !RegexValidator.isValidShopName(sanitizedValue)) {
          return 'Enter a valid shop name ';
        }

        if (widget.isCity && !RegexValidator.isValidCity(sanitizedValue)) {
          return 'Enter a valid city name ';
        }



        return null;
      },
    );
  }
}











enum SuffixIconType {
  passwordToggle,
  loader,
  verified,
  failed,
  none,
}

class SuffixIconBuilder {
  static Widget? build({
    required BuildContext context,
    required bool isPassword,
    required bool isBank,
    required bool showLoader,
    required bool isVerified,
    required bool isFailed,
    required bool obscurePassword,
    required VoidCallback toggleObscure,
  }) {
    final type = _resolveSuffixIconType(
      isPassword: isPassword,
      isBank: isBank,
      showLoader: showLoader,
      isVerified: isVerified,
      isFailed: isFailed,
    );

    switch (type) {
      case SuffixIconType.passwordToggle:
        return IconButton(
          icon: Icon(
            obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: toggleObscure,
        );
      case SuffixIconType.loader:
        return SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case SuffixIconType.verified:
        return Icon(Icons.check_circle, color: Colors.green);
      case SuffixIconType.failed:
        return Icon(Icons.cancel, color: Colors.red);
      case SuffixIconType.none:
      default:
        return null;
    }
  }

  static SuffixIconType _resolveSuffixIconType({
    required bool isPassword,
    required bool isBank,
    required bool showLoader,
    required bool isVerified,
    required bool isFailed,
  }) {
    if (isPassword) {
      return SuffixIconType.passwordToggle;
    } else if (isBank && showLoader) {
      return SuffixIconType.loader;
    } else if (isBank && isVerified) {
      return SuffixIconType.verified;
    } else if (isBank && isFailed) {
      return SuffixIconType.failed;
    }
    return SuffixIconType.none;
  }
}
