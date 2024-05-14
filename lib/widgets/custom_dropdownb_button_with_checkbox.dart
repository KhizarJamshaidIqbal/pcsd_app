// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';

class CustomDropdownButtonWithCheckBox extends StatefulWidget {
  final List<String> items;
  final List<String> selectedValues;
  final ValueChanged<List<String>> onChanged;

  const CustomDropdownButtonWithCheckBox({
    super.key,
    required this.items,
    required this.selectedValues,
    required this.onChanged,
  });

  @override
  _CustomDropdownButtonWithCheckBoxState createState() =>
      _CustomDropdownButtonWithCheckBoxState();
}

class _CustomDropdownButtonWithCheckBoxState
    extends State<CustomDropdownButtonWithCheckBox> {
  late List<String> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = List<String>.from(widget.selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: globalColors.WhiteColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          final String value = widget.items[index];
          final bool isSelected = selectedValues.contains(value);
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            overlayColor: MaterialStateProperty.all(globalColors.primaryColor),
            checkColor: globalColors.WhiteColor,
            activeColor: globalColors.primaryColor,
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            title: CustomText(
              text: value,
              color: globalColors.WhiteColor,
              fontsize: 20,
            ),
            value: isSelected,
            onChanged: (bool? newValue) {
              setState(() {
                if (newValue != null && newValue) {
                  selectedValues.add(value);
                } else {
                  selectedValues.remove(value);
                }
                widget.onChanged(selectedValues.toList());
              });
            },
          );
        },
      ),
    );
  }
}
