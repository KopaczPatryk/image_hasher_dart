import 'package:equatable/equatable.dart';

/// Represents smallest portion of image hash
class HashPixel with EquatableMixin {
  final int r;
  final int g;
  final int b;
  final int a;

  @override
  List<int> get props => [
        r,
        g,
        b,
        a,
      ];

  const HashPixel({
    required this.r,
    required this.g,
    required this.b,
    required this.a,
  });
}
