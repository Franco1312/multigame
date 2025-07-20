import 'package:flutter/material.dart';
import 'package:multigame/src/core/constants/app_colors.dart';
import 'package:multigame/src/core/constants/app_text_styles.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color.fromARGB(255, 87, 158, 99),
  primaryColorLight: const Color.fromARGB(255, 87, 158, 99),
  primaryColorDark: const Color.fromARGB(255, 87, 158, 99),
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color.fromARGB(255, 87, 158, 99),
    secondary: const Color.fromARGB(255, 87, 158, 99),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.white.withAlpha(242),
    indicatorColor: const Color.fromARGB(255, 123, 177, 125).withAlpha(76),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Color.fromARGB(255, 123, 177, 125),
        );
      }
      return const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: Color.fromARGB(255, 124, 158, 124),
      );
    }),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(
          color: Color.fromRGBO(123, 177, 125, 1),
          size: 28,
        );
      }
      return const IconThemeData(
        color: Color.fromARGB(255, 124, 158, 124),
        size: 24,
      );
    }),
  ),
  textTheme: TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    bodyLarge: AppTextStyles.bodyLarge,
    bodySmall: AppTextStyles.bodySmall,
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Color.fromRGBO(123, 177, 125, 1)),
    backgroundColor: Colors.white,
    elevation: 1,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 182, 218, 185),
      foregroundColor: Colors.white,
      textStyle: AppTextStyles.bodyLarge,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);
