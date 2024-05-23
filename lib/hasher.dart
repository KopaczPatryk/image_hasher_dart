import 'dart:async';

import 'package:image/image.dart';

import 'models/image_hash.dart';
import 'models/hash_pixel.dart';

class Hasher {
  final int size;
  final int depth;

  final int _depthDivider;

  const Hasher({
    this.size = 32,
    this.depth = 8,
  }) : _depthDivider = 256 ~/ depth;

  HashPixel _colorToHashPixel(int color) => HashPixel(
        r: getRed(color) ~/ _depthDivider,
        g: getGreen(color) ~/ _depthDivider,
        b: getBlue(color) ~/ _depthDivider,
        a: getAlpha(color) ~/ _depthDivider,
      );

  int _abgrToArgb(int abgrColor) {
    int r = (abgrColor >> 16) & 0xFF;
    int b = abgrColor & 0xFF;
    return (abgrColor & 0xFF00FF00) | (b << 16) | r;
  }

  //FIXME: Its not async but has future return type
  FutureOr<ImageHash> getImageHash(Image src) {
    final future = Future(() {
      final image = copyResize(
        src,
        width: size,
        height: size,
      );
      final hash = ImageHash(
        depth: depth,
        resolution: size,
      );

      int normalizedIndex = 0;
      for (int x = 0; x < image.width; x++) {
        for (int y = 0; y < image.height; y++) {
          final abgrPixel = image.getPixel(x, y);

          final rgbPixel = _abgrToArgb(abgrPixel);
          final hashPixel = _colorToHashPixel(rgbPixel);
          hash[normalizedIndex] = hashPixel;
          normalizedIndex++;
        }
      }
      return hash;
    });

    return future;
  }
}
