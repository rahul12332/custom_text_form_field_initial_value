import 'package:flutter/material.dart';
import 'regax_validator.dart';
import 'app_color.dart';

/// Enum representing the direction of text field entry animation.
/// Helps keep direction options type-safe and IDE-suggested.
enum AnimationDirection { left, right, up, down }

/// ---------------------------------------------------------------------------
/// 🧩 CustomTextFormFieldInitialValue
/// ---------------------------------------------------------------------------
/// A highly customizable TextFormField widget with:
/// - Built-in validations for mobile, GSTIN, PIN code, etc.
/// - Optional animation for field entry (sliding in from any direction).
/// - Support for sequential animation using animationOrder.
/// - Optional initial value handling and password visibility toggle.
/// ---------------------------------------------------------------------------
@immutable
class CustomTextFormFieldInitialValue extends StatefulWidget {
  // ------------------------------------------------------------
  // 🎯 Basic Field Properties
  // ------------------------------------------------------------
  final TextEditingController? controller; // To manage text state externally.
  final String? initialValue;              // Optional prefilled text.
  final String hintText;                   // Placeholder text.
  final TextInputType keyboardType;        // Input type like text, number, email.
  final bool obscureText;                  // For password-type fields.
  final int? minLength;                    // Optional min character limit.
  final int? maxLength;                    // Optional max character limit.

  // ------------------------------------------------------------
  // ⚙️ Validation Flags (enable built-in validation per field type)
  // ------------------------------------------------------------
  final bool isPassword;
  final bool isMobileNo;
  final bool isGstin;
  final bool isPinCode;
  final bool isState;
  final bool isName;
  final bool isAddress;
  final bool isShopName;
  final bool isCity;
  final bool isBank;
  final bool? firstName;
  final bool? lastName;

  // ------------------------------------------------------------
  // 🗓️ Date-Related Fields (for from/to date input)
  // ------------------------------------------------------------
  final bool isFromDate;
  final bool isToDate;
  final DateTime? fromDate;

  // ------------------------------------------------------------
  // 🎨 Styling Properties
  // ------------------------------------------------------------
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final double borderWidth;
  final String? label;
  final bool showLabel;
  final Color labelColor;
  final Color OutlineInputBorder;
  final double borderRadious;
  final Color? backgroundColor;
  final Color? hintColor;
  final Color? borderColor;

  // ------------------------------------------------------------
  // 🧭 Animation Properties
  // ------------------------------------------------------------
  final bool enableAnimation;              // Enables/disables animation.
  final AnimationDirection animationDirection; // Direction of field slide-in.
  final Duration animationDuration;        // Duration of individual animation.
  final int animationOrder;                // Sequence number of animation (1, 2, 3...).
  final Duration baseDelay;                // Base delay between each field animation.

  // ------------------------------------------------------------
  // ⚡ Miscellaneous
  // ------------------------------------------------------------
  final bool showLoader;                   // Option to show loader UI.
  final VoidCallback? onTap;               // Custom onTap callback (used for date fields).

  CustomTextFormFieldInitialValue({
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
    this.isPinCode = false,
    this.isState = false,
    this.isName = false,
    this.isAddress = false,
    this.isShopName = false,
    this.isCity = false,
    this.isBank = false,
    this.firstName = false,
    this.lastName = false,
    this.isFromDate = false,
    this.isToDate = false,
    this.fromDate,
    this.onTap,
    this.borderColor,
    this.showLoader = false,
    this.enabledBorderColor = AppColor.boderColor,
    this.focusedBorderColor = AppColor.boderColor,
    this.borderWidth = 1,
    this.label,
    this.showLabel = false,
    this.labelColor = Colors.red,
    this.borderRadious = 16,
    this.OutlineInputBorder = AppColor.boderColor,
    this.backgroundColor,
    this.hintColor,

    // Animation defaults
    this.enableAnimation = false,
    this.animationDirection = AnimationDirection.left,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationOrder = 1,
    this.baseDelay = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<CustomTextFormFieldInitialValue> createState() =>
      _CustomTextFormFieldInitialValue();
}

/// ---------------------------------------------------------------------------
/// 🎬 _CustomTextFormFieldInitialValue State Class
/// ---------------------------------------------------------------------------
/// Handles animations, password visibility, date selection, and validations.
/// ---------------------------------------------------------------------------
class _CustomTextFormFieldInitialValue
    extends State<CustomTextFormFieldInitialValue>
    with SingleTickerProviderStateMixin {
  bool _obscurePassword = true;
  DateTime? _fromDate;
  DateTime? _toDate;

  late AnimationController _controller;     // Controls slide animation.
  late Animation<Offset> _offsetAnimation;  // Defines slide movement direction.

  @override
  void initState() {
    _fromDate = widget.fromDate;
    super.initState();

    // 🎞️ Initialize animation controller with user-defined duration
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    // 🚀 Determine the starting direction of animation
    Offset beginOffset;
    switch (widget.animationDirection) {
      case AnimationDirection.right:
        beginOffset = const Offset(1.0, 0.0);
        break;
      case AnimationDirection.up:
        beginOffset = const Offset(0.0, 1.0);
        break;
      case AnimationDirection.down:
        beginOffset = const Offset(0.0, -1.0);
        break;
      case AnimationDirection.left:
      default:
        beginOffset = const Offset(-1.0, 0.0);
    }

    // 🎯 Setup Tween for movement from 'beginOffset' to original position
    _offsetAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // 🕒 Trigger animation with delay based on field order
    // Example:
    //   order 1 → 0ms delay
    //   order 2 → 300ms delay
    //   order 3 → 600ms delay
    if (widget.enableAnimation) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(widget.baseDelay * (widget.animationOrder - 1), () {
          if (mounted) _controller.forward();
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    if (widget.controller == null) {
      widget.controller?.dispose();
    }
    super.dispose();
  }

  /// ✅ Validates "To Date" should not be earlier than "From Date"
  void validateDatesFromController() {
    if (_fromDate != null && _toDate != null && _toDate!.isBefore(_fromDate!)) {
      widget.controller?.text = '';
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('To Date cannot be earlier than From Date'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  /// 🧱 Builds the actual text field UI with styling and validation
  Widget _buildTextField(BuildContext context) {
    return TextFormField(
      onTap: () async {
        // 📅 Date Picker Integration
        if (widget.isFromDate || widget.isToDate) {
          DateTime initialDate = DateTime.now();
          if (widget.isToDate && _fromDate != null) {
            initialDate = _fromDate!;
          }

          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            widget.controller?.text =
            pickedDate.toLocal().toString().split(' ')[0];

            if (widget.isFromDate) {
              _fromDate = pickedDate;
            } else if (widget.isToDate) {
              _toDate = pickedDate;
            }

            validateDatesFromController();
            setState(() {});
          }
        }

        // 🪄 Execute custom onTap callback if provided
        widget.onTap?.call();
      },
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscurePassword : widget.obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.showLabel ? widget.label : null,
        hintText: widget.hintText,
        fillColor: widget.backgroundColor ?? Colors.white,
        filled: true,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: widget.labelColor,
        ),
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: widget.hintColor ?? AppColor.hintColor,
        ),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.OutlineInputBorder, width: widget.borderWidth),
          borderRadius: BorderRadius.circular(widget.borderRadious),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.focusedBorderColor),
          borderRadius: BorderRadius.circular(widget.borderRadious),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.enabledBorderColor),
          borderRadius: BorderRadius.circular(widget.borderRadious),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(widget.borderRadious),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () =>
              setState(() => _obscurePassword = !_obscurePassword),
        )
            : null,
      ),
      validator: (value) {
        // ⚠️ Common empty field validation
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a ${widget.hintText.toLowerCase()}';
        }

        // ✨ Use RegexValidator for field-specific checks
        final trimmed = value.trim();

        if (widget.isMobileNo &&
            !RegexValidator.isValidIndianMobile(trimmed)) {
          return 'Enter a valid 10-digit mobile number';
        }
        if (widget.isGstin && !RegexValidator.isValidGstin(trimmed)) {
          return 'Invalid GSTIN';
        }
        if (widget.isPassword &&
            !RegexValidator.isValidPassword(trimmed)) {
          return 'Password must include letters, numbers & symbols';
        }
        if (widget.isPinCode && !RegexValidator.isValidPinCode(trimmed)) {
          return 'Invalid PIN Code';
        }
        if (widget.isState &&
            !RegExp(r"^[A-Za-z ]{3,30}$").hasMatch(trimmed)) {
          return 'Enter a valid state name';
        }
        if (widget.isName && !RegexValidator.isValidName(trimmed)) {
          return 'Enter a valid name';
        }
        if (widget.isAddress && !RegexValidator.isValidAddress(trimmed)) {
          return 'Enter a valid address';
        }
        if (widget.isShopName &&
            !RegexValidator.isValidShopName(trimmed)) {
          return 'Enter a valid shop name';
        }
        if (widget.firstName! &&
            !RegexValidator.isValidFirstName(trimmed)) {
          return 'Enter a valid first name';
        }
        if (widget.lastName! &&
            !RegexValidator.isValidLastName(trimmed)) {
          return 'Enter a valid last name';
        }
        if (widget.isCity && !RegexValidator.isValidCity(trimmed)) {
          return 'Enter a valid city name';
        }
        if (widget.isBank &&
            !RegexValidator.isValidBankAccount(trimmed)) {
          return "Enter a valid bank account";
        }

        return null; // ✅ All validations passed
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🧠 Initialize controller text from initialValue (if provided)
    if (widget.controller != null &&
        widget.initialValue != null &&
        widget.controller!.text.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.controller!.text = widget.initialValue!;
      });
    }

    // 🎞️ Wrap text field with SlideTransition if animation is enabled
    return widget.enableAnimation
        ? SlideTransition(
      position: _offsetAnimation,
      child: _buildTextField(context),
    )
        : _buildTextField(context);
  }
}
