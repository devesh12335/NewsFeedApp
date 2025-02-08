import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String> items;
  final String title;
  final String hint;
  final ValueChanged<String> onItemSelected;
  String? selectedItem;
  final double width;
  final bool isRequired;

  CustomDropdownButton({
    required this.items,
    required this.onItemSelected,
    required this.title,
    required this.hint,
    this.selectedItem,
    this.width = 200,
    this.isRequired = false, // Flag for making the field required
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState(selectedItem: selectedItem);
}

class _CustomDropdownState extends State<CustomDropdownButton> {
  String? selectedItem;

  _CustomDropdownState({required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: selectedItem,
      validator: (value) {
        if (widget.isRequired && (value == null || value.isEmpty)) {
          return 'Select a Option';
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade50,
                border: Border.all(color: state.hasError ? Colors.red : Colors.blueGrey, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: selectedItem,
                hint: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    widget.hint,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                items: widget.items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: SizedBox(
                      width: widget.width,
                      child: Text(item, softWrap: true),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue;
                    state.didChange(newValue); // Updates the FormField state
                  });
                  widget.onItemSelected(newValue!);
                },
                isExpanded: true,
                underline: SizedBox(),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  state.errorText ?? '',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
