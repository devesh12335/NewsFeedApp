import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../presentation/resources/color_manager.dart';
import '../presentation/resources/style_manager.dart';
import '../presentation/resources/values_manager.dart';

class InputField extends StatelessWidget {
  final BuildContext context1;
  final TextEditingController? controller;
  final double width;
  final String hint;
  final String labelText;
  final bool hideText;
  final RegExp? regExp;
  final String? keyboardType;
  final String? prefixText;
  final TextInputType textInputType;
  final String? Function(String? validator)? validator;
  final String? errorText;
  final int? maxLines;
  TextInputFormatter? formatter = FilteringTextInputFormatter('', allow: true);
  void Function(String data)? onSubmit;
  void Function(String data)? onChanged;
  void Function(bool data)? validateValue;
  TextCapitalization? textCapitalization = TextCapitalization.none;

  InputField(
      {super.key,
      required this.controller,
      required this.width,
      required this.hint,
      required this.labelText,
      required this.context1,
      this.prefixText,
      this.keyboardType,
      this.hideText = false,
      this.regExp,
      this.textInputType = TextInputType.text,
      this.validator,
      this.maxLines = 1,
      this.errorText,
      this.validateValue,
      this.onSubmit, // bool? validateValue
      this.onChanged, // bool? validateValue
      this.formatter,
      this.textCapitalization});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Increased height to accommodate error message
      width: width,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context1).viewInsets.top),
      margin: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            inputFormatters: [
              formatter ?? FilteringTextInputFormatter.allow(RegExp(r'.*'))
            ],
            maxLines: maxLines,
            onChanged: onChanged,
            onFieldSubmitted: onSubmit,
            keyboardType: textInputType,
            obscureText: hideText,
            controller: controller,
            //  maxLength: 100,
            style: TextStyle(color: ColorManager.themeText, fontSize: 15),
            decoration: InputDecoration(
              prefixStyle: getSemi14tyle(color: ColorManager.themeText),
              prefixText: prefixText,
              filled: true,
              fillColor: ColorManager.darkGrey,
              // labelText: labelText,
              hintText: hint,


              hintStyle: TextStyle(fontSize: 13,color: ColorManager.themeText),
              labelStyle: TextStyle(fontSize: 13,color: ColorManager.themeText),
              errorText: errorText,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s8),
                borderSide:
                BorderSide(color: ColorManager.textFieldBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s8),
                borderSide: BorderSide(color: ColorManager.themeText),
              ),
              // errorBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(AppSize.s8),
              //   borderSide: const BorderSide(color: Colors.red),
              // ),
              // focusedErrorBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(AppSize.s8),
              //   borderSide: const BorderSide(color: Colors.red),
              // ),
            ),
            validator: (value) {
              if (validator != null) {
                // print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++${value}");
                // return validator!(value);

              } else if (regExp != null && !regExp!.hasMatch(value ?? '' )|| value == null || value.isEmpty) {
                return 'Invalid input';
              }else if(value == null) {
                  return '${labelText} is required field';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // validator: (text) {
          //     print(
          //         "Custom validator is being executed112"); // Debugging output

          //     if (validator != null) {
          //       // Use the custom validator function if it is provided
          //       return validator!(text);
          //     } else {
          //       // Execute the default validation logic
          //       if (text != null && regExp != null) {
          //         bool isValid = regExp!.hasMatch(text);
          //         if (isValid) {
          //           validateValue?.call(true);
          //           return null;
          //         } else {
          //           validateValue?.call(false);
          //           return "Enter Is Invalid";
          //         }
          //       } else if (text == null || text.isEmpty) {
          //         return "$labelText Cannot Be Empty";
          //       }
          //     }
          //     return null; // Return null if all validations pass
          //   },
          ),
          // if (errorText != null && errorText!.isNotEmpty)
          //   Padding(
          //     padding: const EdgeInsets.only(top: 4),
          //     child: Text(
          //       errorText!,
          //       style: const TextStyle(color: Colors.red, fontSize: 12),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
