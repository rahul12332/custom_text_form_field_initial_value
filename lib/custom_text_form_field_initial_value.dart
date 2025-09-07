import 'package:flutter/material.dart';
import 'regax_validator.dart';
import 'app_color.dart';

class CustomTextFormField_initialvalue extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? minLength;
  final int? maxLength;
  final bool isPassword;
  final bool isMobileNo;
  final bool isGstin; // ✅ Only GSTIN validation
  final VoidCallback? onTap;

  // Optional border color
  final Color? borderColor;

  final bool showLoader;
  final bool isPinCode;
  final bool isState;
  final bool isName;
  final bool isAddress;
  final bool isShopName;
  final bool isCity;

  const CustomTextFormField_initialvalue({
    Key? key,
    this.controller,
    this.initialValue,
    required this.hintText,
    required this.keyboardType,
    this.obscureText = false,
    this.minLength,
    this.maxLength,
    this.isPassword = false,
    this.isMobileNo = false,
    this.isGstin = false,
    this.onTap,
    this.borderColor, // 👈 optional
    this.showLoader = false,
    this.isPinCode = false,
    this.isState = false,
    this.isName = false,
    this.isAddress = false,
    this.isShopName = false,
    this.isCity = false,
  }) : super(key: key);

  @override
  State<CustomTextFormField_initialvalue> createState() =>
      _CustomTextFormField_initialvalueState();
}

class _CustomTextFormField_initialvalueState
    extends State<CustomTextFormField_initialvalue> {
  bool _obscurePassword = true;

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
      onTap: widget.onTap,
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
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        border: OutlineInputBorder(
          borderSide:
          BorderSide(color: widget.borderColor ?? AppColor.boderColor),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: widget.borderColor ?? AppColor.boderColor),
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: widget.borderColor ?? AppColor.boderColor),
          borderRadius: BorderRadius.circular(16.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(16.0),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        )
            : null,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a ${widget.hintText.toLowerCase()}';
        }

        String sanitizedValue = value.replaceAll(' ', '');

        if (widget.isMobileNo &&
            !RegexValidator.isValidIndianMobile(sanitizedValue)) {
          return 'Enter a valid 10-digit mobile number';
        }

        if (widget.isGstin && !RegexValidator.isValidGstin(sanitizedValue)) {
          return 'Invalid GSTIN';
        }

        if (widget.isPassword &&
            !RegexValidator.isValidPassword(sanitizedValue)) {
          return 'Password must be at least 6 characters and include numbers, letters, and special characters (!\$@%)';
        }

        if (widget.isPinCode && !RegexValidator.isValidPinCode(sanitizedValue)) {
          return 'Invalid PIN Code. It should be exactly 6 digits.';
        }

        if (widget.isState) {
          final RegExp stateRegex = RegExp(r"^[A-Za-z ]{3,30}$");
          if (!stateRegex.hasMatch(sanitizedValue)) {
            return 'Enter a valid state name';
          }
        }

        if (widget.isName && !RegexValidator.isValidName(sanitizedValue)) {
          return 'Enter a valid name';
        }

        if (widget.isAddress && !RegexValidator.isValidAddress(sanitizedValue)) {
          return 'Enter a valid address';
        }

        if (widget.isShopName && !RegexValidator.isValidShopName(sanitizedValue)) {
          return 'Enter a valid shop name';
        }

        if (widget.isCity && !RegexValidator.isValidCity(sanitizedValue)) {
          return 'Enter a valid city name';
        }

        return null;
      },
    );
  }
}
