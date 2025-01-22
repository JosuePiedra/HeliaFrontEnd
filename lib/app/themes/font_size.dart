import 'package:helia_frontend/app/themes/responsive.dart';

abstract class FontSize {
  static final display = _DisplayFont();
  static final headline = _HeadlineFont();
  static final title = _TitleFont();
  static final label = _LabelFont();
  static final body = _BodyFont();
}

class _DisplayFont {
  final double large;
  final double medium;
  final double small;

  _DisplayFont()
      : large = Responsive().ip(12),
        medium = Responsive().ip(6),
        small = Responsive().ip(4.8);
}

class _HeadlineFont {
  final double large;
  final double medium;
  final double small;

  _HeadlineFont()
      : large = Responsive().ip(4.25),
        medium = Responsive().ip(3.65),
        small = Responsive().ip(2.5);
}

class _TitleFont {
  final double large;
  final double medium;
  final double small;

  _TitleFont()
      : large = Responsive().ip(2.1),
        medium = Responsive().ip(1.7),
        small = Responsive().ip(1.5);
}

class _LabelFont {
  final double large;
  final double medium;
  final double small;

  _LabelFont()
      : large = Responsive().ip(1.5),
        medium = Responsive().ip(1.25),
        small = Responsive().ip(1.1);
}

class _BodyFont {
  final double large;
  final double medium;
  final double small;

  _BodyFont()
      : large = Responsive().ip(1.7),
        medium = Responsive().ip(1.5),
        small = Responsive().ip(1.25);
}
