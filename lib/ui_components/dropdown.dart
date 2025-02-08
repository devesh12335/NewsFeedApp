// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../presentation/resources/color_manager.dart';
import '../presentation/resources/values_manager.dart';

class Dropdown extends StatefulWidget {
  final List<String> items;
  final String title;
  final String hint;
  final ValueChanged<String> onItemSelected;
  final String? errorText;
  final String? selectedItem; // Keep as final to get value from parent widget
  final double width;
  final FormFieldValidator<String>? validator;

  const Dropdown({
    Key? key,
    required this.items,
    required this.onItemSelected,
    required this.title,
    required this.hint,
    this.selectedItem,
    this.errorText,
    this.width = 200,
     this.validator
  }) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    // Initialize with the passed selectedItem from the parent widget
    selectedItem = widget.selectedItem;
  }

  @override
  void didUpdateWidget(Dropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update selectedItem if it changes from the parent widget
    if (widget.selectedItem != oldWidget.selectedItem) {
      setState(() {
        selectedItem = widget.selectedItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure selectedItem is null if it's not in the items list
    if (selectedItem != null && !widget.items.contains(selectedItem)) {
      selectedItem = null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: selectedItem,
          hint: SizedBox(
            child: Text(
              widget.hint,
              style: TextStyle(fontSize: 14),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          items: widget.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: SizedBox(
                child: Text(
                  item,
                  style: TextStyle(fontSize: 14),
                  softWrap: true,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedItem = newValue;
            });
            widget.onItemSelected(newValue!);
          },
          // autovalidateMode: ,
          validator: widget.validator, // Added validator here
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.lightBlue.shade50,
            labelText: widget.title,
            errorText: widget.errorText,
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
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}



// class Dropdown extends StatefulWidget {
//   final List<String> items;
//   final String title;
//   final String hint;
//   final ValueChanged<String> onItemSelected;
//   final String? errorText;
//   final String? selectedItem; // Keep as final to get value from parent widget
//   final double width;
//    final FormFieldValidator<String>? validator;

//   const Dropdown({
//     Key? key,
//     required this.items,
//     required this.onItemSelected,
//     required this.title,
//     required this.hint,
//     this.selectedItem,
//     this.errorText,
//     this.width = 200,
//     this.validator
//   }) : super(key: key);


//   @override
//   _CustomDropdownState createState() => _CustomDropdownState(selectedItem: selectedItem);
// }

// class _CustomDropdownState extends State<Dropdown> {
//   String? selectedItem;

//   _CustomDropdownState({this.selectedItem});
  
// @override
// Widget build(BuildContext context) {
//   // Ensure selectedItem is part of the list, else set to null
//   if (selectedItem != null && !widget.items.contains(selectedItem)) {
//     selectedItem = null;
//   }

//   return DropdownButtonFormField<String>(
//     dropdownColor: Colors.white,
//     value: selectedItem,
//     hint: SizedBox(
//       width: MediaQuery.of(context).size.width * 0.7,
//       child: Text(
//         widget.hint,
//         softWrap: true,
//         overflow: TextOverflow.ellipsis,
//       ),
//     ),
//     items: widget.items.map((String item) {
//       return DropdownMenuItem<String>(
//         value: item,
//         child: SizedBox(
//           width: widget.width,
//           child: Text(item, softWrap: true, style: TextStyle(fontSize: 12)),
//         ),
//       );
//     }).toList(),
//     onChanged: (String? newValue) {
//       setState(() {
//         selectedItem = newValue;
//       });
//       widget.onItemSelected(newValue!);
//     },
//     validator: widget.validator,
//     decoration: InputDecoration(
//       errorText: widget.errorText,
//       filled: true,
//       fillColor: Colors.lightBlue.shade50,
//       labelText: widget.title,
//       border: OutlineInputBorder(),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(AppSize.s8),
//         borderSide: BorderSide(color: ColorManager.textFieldBorderColor),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(AppSize.s8),
//         borderSide: BorderSide(color: ColorManager.textFieldBorderColor),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(AppSize.s8),
//         borderSide: BorderSide(color: Colors.red),
//       ),
//     ),
//   );
// }

// }