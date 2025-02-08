import 'package:news_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomInputField({
    Key? key,
    required this.labelText,
    this.controller,
    required this.onChanged,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        onChanged: onChanged,
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction, //added
        keyboardType: keyboardType,
        style: TextStyle(
            color: ColorManager.themeText,
            fontSize: 15), // Set text color to white
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
                color: ColorManager.themeText), // Set label text color to white
            fillColor:
                ColorManager.darkGrey, // Set the background color to grey
            filled: true, // Enable the fill color
            border: InputBorder.none, // Set this to none to remove border
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.transparent), // Transparent border when focused
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                      Colors.transparent), // Transparent border in normal state
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            )),
        validator: validator,
      ),
    );
  }
}













// import 'package:news_app/presentation/resources/color_manager.dart';
// import 'package:flutter/material.dart';

// class CustomInputField extends StatelessWidget {
//   final String labelText;
//   final Function(String) onChanged;
//   final TextEditingController? controller;
//   final String? initialValue;
//   final TextInputType keyboardType;
//   final bool obscureText;

//   const CustomInputField({
//     Key? key,
//     required this.labelText,
//     this.controller,
//     required this.onChanged,
//     this.initialValue,
//     this.keyboardType = TextInputType.text,
//     this.obscureText = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: TextFormField(
//         controller: controller,
//         initialValue: initialValue,
//         onChanged: onChanged,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         style: TextStyle(
//             color: ColorManager.themeText,
//             fontSize: 15), // Set text color to white
//         decoration: InputDecoration(
//           labelText: labelText,
//           labelStyle: TextStyle(
//               color: ColorManager.themeText), // Set label text color to white
//           fillColor: ColorManager.darkGrey, // Set the background color to grey
//           filled: true, // Enable the fill color
//           border: InputBorder.none, // Set this to none to remove border
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(
//                 color: Colors.transparent), // Transparent border when focused
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(
//                 color:
//                     Colors.transparent), // Transparent border in normal state
//           ),
//         ),
//       ),
//     );
//   }
// }







