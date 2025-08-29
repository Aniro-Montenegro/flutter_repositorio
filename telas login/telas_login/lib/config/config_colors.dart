import 'package:flutter/material.dart';

class ConfigColors {
  // Cor principal (#637684)
  static const Color corPrefeituraAzulPetroleo = Color(0xFF637684);

  static const Color corTextoBotao = Color(0xFFF5F5F5);

  // Cor verde (#0b782e)
  static const Color corPrefeituraVerde = Color(0xFF0B782E);

  // Cor cinza escuro (#2c2a24)
  static const Color corPrefeituraCinzaEscuro = Color(0xFF2C2A24);

  // Cor dourada (#d5c762)
  static const Color corPrefeituraDourado = Color(0xFFD5C762);

  // Cor vermelha (#ef2414)
  static const Color corPrefeituraVermelho = Color(0xFFEF2414);

  // Azul Petróleo
  static final WidgetStateProperty<Color?> corAzulPetroleo =
      WidgetStateProperty.all(const Color(0xFF637684));

// Verde
  static final WidgetStateProperty<Color?> corVerde =
      WidgetStateProperty.all(const Color(0xFF0B782E));

// Cinza Escuro
  static final WidgetStateProperty<Color?> corCinzaEscuro =
      WidgetStateProperty.all(const Color(0xFF2C2A24));

// Dourado
  static final WidgetStateProperty<Color?> corDourado =
      WidgetStateProperty.all(const Color(0xFFD5C762));

// Vermelho
  static final WidgetStateProperty<Color?> corVermelho =
      WidgetStateProperty.all(const Color(0xFFEF2414));

  // Versões com opacidade reduzida (opcionais)
  static Color corPrefeituraAzulPetroleo50 =
      const Color(0xFF637684).withOpacity(0.5);
  static Color corPrefeituraVerde50 = const Color(0xFF0B782E).withOpacity(0.5);
  static Color corPrefeituraCinzaEscuro50 =
      const Color(0xFF2C2A24).withOpacity(0.5);
  static Color corPrefeituraDourado50 =
      const Color(0xFFD5C762).withOpacity(0.5);
  static Color corPrefeituraVermelho50 =
      const Color(0xFFEF2414).withOpacity(0.5);
}
