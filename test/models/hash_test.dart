import 'package:image_hasher_dart/models/hash_pixel.dart';
import 'package:image_hasher_dart/models/image_hash.dart';
import 'package:test/test.dart';

void main() {
  test('hashes with same const hashPixels are equal', () {
    final a = ImageHash(resolution: 1, depth: 8);
    final b = ImageHash(resolution: 1, depth: 8);
    const hashPixel = HashPixel(r: 1, g: 2, b: 3, a: 4);

    a[0] = hashPixel;
    b[0] = hashPixel;

    expect(a, equals(b));
  });

  test('hashes with same hashPixels are equal', () {
    final a = ImageHash(resolution: 1, depth: 8);
    final b = ImageHash(resolution: 1, depth: 8);
    const hashPixel = HashPixel(r: 1, g: 2, b: 3, a: 4);
    const hashPixel2 = HashPixel(r: 1, g: 2, b: 3, a: 4);

    a[0] = hashPixel;
    b[0] = hashPixel2;

    expect(a, equals(b));
  });

  test('hashes with different hash arrays are not equal', () {
    final a = ImageHash(resolution: 1, depth: 8);
    final b = ImageHash(resolution: 1, depth: 8);
    const hashPixel = HashPixel(r: 1, g: 2, b: 3, a: 4);

    a[0] = hashPixel;

    expect(a, isNot(equals(b)));
  });

  test('hashes with different depths are not equal', () {
    final a = ImageHash(resolution: 1, depth: 8);
    final b = ImageHash(resolution: 1, depth: 4);

    const hashPixel = HashPixel(r: 1, g: 2, b: 3, a: 4);
    const hashPixel2 = HashPixel(r: 1, g: 2, b: 3, a: 4);

    a[0] = hashPixel;
    b[0] = hashPixel2;

    expect(a, isNot(equals(b)));
  });
}
