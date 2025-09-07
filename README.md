# Custom Text Form Field

A customizable Flutter TextFormField widget with built-in validation and suffix icon handling.

## Features
- Supports Aadhaar, PAN, Bank Account, IFSC, GSTIN validations.
- Password visibility toggle.
- Bank account verification loader & status icons.
- Optional GSTIN validation depending on turnover.

## Usage

```dart
CustomTextFormField(
  controller: myController,
  hintText: "Enter your PAN",
  keyboardType: TextInputType.text,
  isPan: true,
);
# custom_text_form_field_initial_value
