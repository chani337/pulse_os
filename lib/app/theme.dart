import 'package:flutter/material.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFF7C5CFF),
    secondary: const Color(0xFF37D6FF),
    surface: const Color(0x14FFFFFF),
    background: const Color(0xFF0B1020),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: const Color(0xE8FFFFFF),
    onBackground: const Color(0xE8FFFFFF),
  ),
  scaffoldBackgroundColor: const Color(0xFF0B1020),
  // fontFamily: 'Schyler',  // 폰트 파일이 있을 때만 주석 해제
);
