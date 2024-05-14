import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcsd_app/constants/colors.dart';
import 'package:pcsd_app/widgets/custom_Text_Widget.dart';
class CustomDropdownButton extends StatelessWidget {
  final List<String> items;
  final String value;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: globalColors.WhiteColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          padding: const EdgeInsets.all(8),
          child: DropdownButton<String>(
            icon: const Icon(
              Icons.keyboard_double_arrow_down,
              color: globalColors.WhiteColor,
              size: 25.0,
            ),
            dropdownColor: globalColors.primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            style: GoogleFonts.literata(
              textStyle: const TextStyle(
                color: globalColors.WhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            isExpanded: true,
            value: value,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: CustomText(
                  text: value,
                  color: globalColors.WhiteColor,
                  fontsize: 20,
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
