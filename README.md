# Custom Text Form Field

A customizable Flutter TextFormField widget with built-in validation and suffix icon handling.

## Features
- Aadhaar Validation
- Validates a 12-digit Aadhaar number ensuring the user enters a proper format.

- PAN Validation
- Checks if the input matches the standard PAN format (e.g., ABCDE1234F).

- IFSC Code Validation
- Ensures the input matches standard IFSC format (XXXX0XXXXXX) for Indian banks.

- GSTIN Validation
- Validates GSTIN numbers based on Indian GST rules. You can enable it optionally depending on your requirement.

- Password Field Support
- Supports toggling password visibility with a suffix eye icon, allowing users to show/hide input.

- Initial Value Support
- Allows setting an initial value for the TextFormField if you want pre-filled content.

- Dynamic Suffix Icons
- Shows appropriate icons in the field such as:

- Loader – while bank account verification is in progress.

- Verified – shows a green check if verification succeeds.

- Failed – shows a red cancel icon if verification fails.

- Password toggle – show/hide password for secure fields.

- Flexible Validators
- Supports additional validations like:

- PIN Code (6 digits)

- Name (alphabet-only input)

- State (3–30 characters, alphabet-only)

- City and Shop Name

- Address

- Customizable UI
- Rounded borders, content padding, and hint text styling, fully customizable.

- Optional onTap Callback
- Executes a callback when the field is tapped, useful for custom action

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:custom_text_form_field_initial_value/custom_text_form_field_initial_value.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controllers for each field
  final TextEditingController gstinController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController shopController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom TextFormField Example")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // GSTIN Field
                  CustomTextFormField_initialvalue(
                    controller: gstinController,
                    hintText: "Enter your GSTIN",
                    keyboardType: TextInputType.text,
                    isGstin: true,
                    borderColor: Colors.black,
                  ),

                  const SizedBox(height: 16),

                  // Name Field
                  CustomTextFormField_initialvalue(
                    controller: nameController,
                    hintText: "Enter your Name",
                    keyboardType: TextInputType.text,
                    isName: true,
                    borderColor: Colors.black,
                  ),

                  const SizedBox(height: 16),

                  // Mobile Number Field
                  CustomTextFormField_initialvalue(
                    controller: mobileController,
                    hintText: "Enter Mobile Number",
                    keyboardType: TextInputType.number,
                    isMobileNo: true,
                    borderColor: Colors.black,
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  CustomTextFormField_initialvalue(
                    controller: passwordController,
                    hintText: "Enter Password",
                    keyboardType: TextInputType.text,
                    isPassword: true,
                    borderColor: Colors.black,
                  ),

                  const SizedBox(height: 16),

                  // PIN Code Field
                  CustomTextFormField_initialvalue(
                    controller: pinCodeController,
                    hintText: "Enter PIN Code",
                    keyboardType: TextInputType.number,
                    isPinCode: true,
                    borderColor: Colors.black,
                  ),

                  const SizedBox(height: 16),

                  // State Field
                  CustomTextFormField_initialvalue(
                    controller: stateController,
                    hintText: "Enter State",
                    keyboardType: TextInputType.text,
                    isState: true,
                    borderColor: Colors.black,
                  ),

                  const SizedBox(height: 16),

                  // Address Field
                  CustomTextFormField_initialvalue(
                    controller: addressController,
                    hintText: "Enter Address",
                    keyboardType: TextInputType.text,
                    isAddress: true,
                    borderColor: Colors.black,
                  ),

                  const SizedBox(height: 16),

                  // Shop Name Field
                  CustomTextFormField_initialvalue(
                    controller: shopController,
                    hintText: "Enter Shop Name",
                    keyboardType: TextInputType.text,
                    isShopName: true,
                    borderColor: Colors.black,
                  ),

                  const SizedBox(height: 16),

                  // City Field
                  CustomTextFormField_initialvalue(
                    controller: cityController,
                    hintText: "Enter City",
                    keyboardType: TextInputType.text,
                    isCity: true,
                    borderColor: Colors.black,
                  ),

                  const SizedBox(height: 24),

                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // All fields are valid
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Form submitted successfully")),
                        );
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

# custom_text_form_field_initial_value
