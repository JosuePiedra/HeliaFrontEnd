part of './app_theme.dart';

abstract class AppPalette {
  static const primary = _PrimaryColors();
  static const secondary = _SecondaryColors();
  static const tertiary = _TertiaryColors();

  // White
  static const white = _WhiteColors();

  // Grey
  static const medium = _MediumColors();

  // Black
  static const black = _BlackColors();

  // Success
  static const success = _SuccessColors();

  // Danger
  static const danger = _DangerColors();
}

class _PrimaryColors {
  const _PrimaryColors();

  final dark = const Color(0xFF005DBF); // Azul oscuro
  final base = const Color(0xFF3A6CD9); // Azul principal
  final light = const Color(0xFFB3D9FF); // Azul claro
  final extraLight = const Color(0xFFE5F2FF); // Azul extra claro
  final transparent = const Color.fromARGB(77, 0, 122, 255); // Transparente
}

class _SecondaryColors {
  const _SecondaryColors();

  final dark = const Color(0xFF268F43); // Verde oscuro
  final base = const Color(0xFF34C759); // Verde principal
  final light = const Color(0xFFB7F0C8); // Verde claro
}

class _TertiaryColors {
  const _TertiaryColors();

  final dark = const Color(0xFF3A3A3A); // Gris oscuro
  final base = const Color(0xFF606060); // Gris medio
  final light = const Color(0xFFF4F4F4); // Gris claro
}

class _MediumColors {
  const _MediumColors();

  final dark = const Color(0xFF4A4A4A);
  final base = const Color(0xFF8E8E93);
  final light = const Color(0xFFD1D1D6);
}

class _WhiteColors {
  const _WhiteColors();

  final dark = const Color(0xFFE5E5EA);
  final base = const Color(0xFFFFFFFF); // Blanco puro
  final light = const Color(0xFFF9FAFB); // Blanco suave
}

class _BlackColors {
  const _BlackColors();

  final dark = const Color(0xFF000000); // Negro puro
  final base = const Color(0xFF1C1C1E);
  final light = const Color(0xFF2C2C2E);
}

class _SuccessColors {
  const _SuccessColors();

  final dark = const Color(0xFF1D6E3E);
  final base = const Color(0xFF28A745); // Éxito verde
  final light = const Color(0xFF81C784);
}

class _DangerColors {
  const _DangerColors();

  final dark = const Color(0xFFB71C1C);
  final base = const Color(0xFFFF3B30); // Rojo de alerta principal
  final light = const Color(0xFFFFCDD2);
}
