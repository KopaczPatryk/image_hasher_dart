import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_hasher_dart/models/hash_pixel.dart';

class ImageHash with EquatableMixin {
  /// Into how many parts the pixel channel value is divided
  final int depth;

  /// Array of hash bytes
  final Uint8List hashList;

  /// Size of hash square
  final int resolution;

  int get length => hashList.length;

  @override
  List<Object> get props => [
        depth,
        hashList,
        resolution,
      ];

  ImageHash({
    required this.resolution,
    required this.depth,
    Uint8List? hashList,
  }) : hashList = hashList ?? Uint8List(resolution * resolution * 4);

  HashPixel operator [](int index) {
    final int baseIndex = index * 4;

    return HashPixel(
      r: hashList[baseIndex],
      g: hashList[baseIndex + 1],
      b: hashList[baseIndex + 2],
      a: hashList[baseIndex + 3],
    );
  }

  operator []=(int i, HashPixel value) {
    final baseIndex = i * 4;

    hashList[baseIndex] = value.r;
    hashList[baseIndex + 1] = value.g;
    hashList[baseIndex + 2] = value.b;
    hashList[baseIndex + 3] = value.a;
  }
}
