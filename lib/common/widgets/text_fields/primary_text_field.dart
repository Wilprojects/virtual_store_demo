import 'package:flutter/material.dart';
import 'package:virtual_store_demo/styles/app_colors.dart';
import 'package:virtual_store_demo/styles/text_styles.dart';

class PrimaryTextField extends StatelessWidget {

  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final bool isPassword;
  final TextEditingController controller;
  final IconData? suffixIcon;
  final Function(String)? onChanged;

  const PrimaryTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.keyboardType,
    this.isPassword = false,
    required this.controller,
    this.suffixIcon,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.neutralColor.withValues(alpha: 0.40)
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintText: hintText,
          hintStyle: AppTextStyles.hintTextStyle,
          label: Text(labelText, style: AppTextStyles.labelTextStyle,),
          suffixIcon: suffixIcon != null? Icon(suffixIcon, color: AppColors.neutralColor,): null,
        ),
        style: AppTextStyles.fieldTextStyle,
        keyboardType: keyboardType,
        obscureText: isPassword,
      ),
    );
  }
}
