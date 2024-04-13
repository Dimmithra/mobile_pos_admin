import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pos_adminpanell/utils/color.dart';

class CommonDropdownField extends StatelessWidget {
  const CommonDropdownField({
    super.key,
    required this.jobRoleCtrl,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.padding = 8,
    this.validateOnChange = true,
    this.closedSuffixIcon,
  });

  final TextEditingController jobRoleCtrl;
  final String hintText;
  final List<String>? items;
  final dynamic Function(String)? onChanged;
  final double padding;
  final bool validateOnChange;
  final Widget? closedSuffixIcon;
  @override
  Widget build(BuildContext context) {
    return CustomDropdown.search(
      errorText: '$hintText is Required',
      excludeSelected: false,
      fillColor: kdropDownColor,
      borderSide: const BorderSide(color: kdropDownColor, width: 1),
      hintStyle: const TextStyle(color: kdefTextColor),
      fieldSuffixIcon: const Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: kdefTextColor,
      ),
      selectedStyle: const TextStyle(color: kdefTextColor),
      hintText: hintText,
      // listItemStyle: TextStyle(backgroundColor: kErrorColor),
      items: items,
      controller: jobRoleCtrl,
      onChanged: onChanged,
    );
  }
}
