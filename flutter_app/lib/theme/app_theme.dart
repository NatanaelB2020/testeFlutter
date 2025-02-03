import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.light(primary: Colors.blue),

    // Fonte do aplicativo
    fontFamily: 'Poppins',

    // Definindo o estilo do TextTheme
    textTheme: TextTheme(
      // Títulos e Cabeçalhos
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),

      // Texto do corpo
      bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black54),

      // Subtítulos
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
    ),

    // Estilo da AppBar
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      backgroundColor: Colors.transparent,
    ),

    // Estilo de campos de formulário
    inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),  // Ajustando o padding para criar mais espaço
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blue),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blue),
    ),
    labelStyle: TextStyle(color: Colors.black87, fontSize: 16),
    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
  ),

    // Estilo de botões
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Cor de fundo da tela
    scaffoldBackgroundColor: Colors.white,
  );
}
