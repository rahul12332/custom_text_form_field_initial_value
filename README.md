# custom_text_form_field_initial_value

[![pub package](https://img.shields.io/pub/v/custom_text_form_field_initial_value.svg)](https://pub.dev/packages/custom_text_form_field_initial_value)

A customizable Flutter TextFormField widget with built-in validation and suffix icon handling.

## Features

✅ Aadhaar Validation  
✅ PAN Validation  
✅ IFSC Code Validation  
✅ GSTIN Validation  
✅ Password Field Support  
✅ Initial Value Support  
✅ Dynamic Suffix Icons (Loader, Verified, Failed, Password Toggle)  
✅ Flexible Validators (PIN Code, Name, State, City, Address, Shop Name)  
✅ Customizable UI  
✅ Optional onTap Callback
✅ Bank account Validation
✅ Gender Validation
✅ BankAccountType Validation
✅ Email Validation
✅ DOB Validation







|             | Android                 | iOS               |
|-------------|-------------------------|-------------------|
| **Support** | Android (SDK 21+)       | iOS (13.0+)       |

## Installation

Add the following line to your `pubspec.yaml` under `dependencies`:

```yaml
dependencies:
  custom_text_form_field_initial_value: ^0.1.1
import 'package:flutter/material.dart';
import 'package:custom_text_form_field_initial_value/custom_text_form_field_initial_value.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  CustomTextFormField_initialvalue(
                    controller: gstinController,
                    hintText: "Enter your GSTIN",
                    keyboardType: TextInputType.text,
                    isGstin: true,
                    borderColor: Colors.black,
                  ),
                  const SizedBox(height: 16),

                  CustomTextFormField_initialvalue(
                    controller: nameController,
                    hintText: "Enter your Name",
                    keyboardType: TextInputType.text,
                    isName: true,
                    borderColor: Colors.black,
                  ),
                  const SizedBox(height: 16),

                  CustomTextFormField_initialvalue(
                    controller: mobileController,
                    hintText: "Enter Mobile Number",
                    keyboardType: TextInputType.number,
                    isMobileNo: true,
                    borderColor: Colors.black,
                  ),
                  const SizedBox(height: 16),
       
       //// adding animation with order or position 
       
                  Column(
           children: [
    CustomTextFormFieldInitialValue(
      hintText: "First Name",
      keyboardType: TextInputType.text,
      enableAnimation: true,
      animationDirection: AnimationDirection.left,
      animationOrder: 1,
          ),
          CustomTextFormFieldInitialValue(
      hintText: "Last Name",
      keyboardType: TextInputType.text,
      enableAnimation: true,
      animationDirection: AnimationDirection.right,
      animationOrder: 2,
        ),
    CustomTextFormFieldInitialValue(
      hintText: "Email",
      keyboardType: TextInputType.emailAddress,
      enableAnimation: true,
      animationDirection: AnimationDirection.up,
      animationOrder: 3,
    ),
  ],
);


                 
                  
                              Row(
              children: [
                Expanded(
                  child: CustomTextFormField_initialvalue(

                    controller: _fromDateController,
                    label: "From date",
                    hintText: "Select From Date",
                    keyboardType: TextInputType.datetime,
                    isFromDate: true,
                    fromDate: _fromDate,
                    onTap: () async {
                      DateTime initialDate = _fromDate ?? DateTime.now();
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: initialDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        _fromDate = picked;
                        _fromDateController.text = picked.toLocal().toString().split(' ')[0];
                        setState(() {});
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10), // this id date time 
                Expanded(
                  child: CustomTextFormField_initialvalue(
                    controller: _toDateController,
                    hintText: "Select To Date",
                    keyboardType: TextInputType.datetime,
                    isToDate: true,
                    fromDate: _fromDate,
                    onTap: () async {
                      DateTime initialDate = _toDate ?? _fromDate ?? DateTime.now();
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: initialDate,
                        firstDate: _fromDate ?? DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        if (_fromDate != null && picked.isBefore(_fromDate!)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("To Date cannot be earlier than From Date"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        _toDate = picked;
                        _toDateController.text = picked.toLocal().toString().split(' ')[0];
                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),


                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
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

## 📷 Screenshots

### With GSTIN Field Example
Name Field Example
Password Field Example

<img src="https://raw.githubusercontent.com/rahul12332/custom_text_form_field_initial_value/main/assets/custom_form_image.png" width="300" />


Contributions are welcome!
If you find a bug or want to suggest a feature, please open an issue or submit a pull request.
👉 Contribute on GitHub

🤝 Contributing

Contributions are welcome!  
If you find a bug or want to suggest a feature, please open an issue or submit a pull request.  
👉 [Contribute on GitHub](https://github.com/rahul12332/custom_text_form_field_initial_value)

### Code Contributors

[![Contributors](https://contrib.rocks/image?repo=rahul12332/custom_text_form_field_initial_value)](https://github.com/rahul12332/custom_text_form_field_initial_value/graphs/contributors)
