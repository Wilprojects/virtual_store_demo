import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:virtual_store_demo/styles/app_colors.dart';

class AppTextStyles {
  static final  TextStyle primaryButtonTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white
  );

  static final  TextStyle titleTextStyle = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: AppColors.secondaryColor
  );

  static final  TextStyle labelTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.neutralColor
  );

  static final  TextStyle hintTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.neutralColor
  );

  static final  TextStyle fieldTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryColor
  );

  static final  TextStyle descriptionTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.secondaryColor
  );

  static final  TextStyle buttonTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.secondaryColor
  );

  static final  TextStyle categoryTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.backgroundColor
  );
}