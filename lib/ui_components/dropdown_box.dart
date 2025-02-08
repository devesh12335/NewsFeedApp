
import 'package:flutter/material.dart';


import '../presentation/resources/color_manager.dart';
import '../presentation/resources/font_manager.dart';
import '../presentation/resources/values_manager.dart';

Widget dropdown(String? val, List<String>? lis, String title2,[String? Function(String?)? validator]) {
    return DropdownButtonFormField<String>(
      validator: validator,
      value:val,
      items: lis!.map((title) {
        return DropdownMenuItem<String>(
          
          value: title,
          child: Text(title,

          ),
        );
      }).toList(),
      onChanged: (value) {
       
          val = value;
        
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.lightBlue.shade50,
        labelText: title2,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: BorderSide(color: ColorManager.textFieldBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: BorderSide(color: ColorManager.textFieldBorderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: const BorderSide(color:Colors.red),
        ),
      ),
    );
  }
