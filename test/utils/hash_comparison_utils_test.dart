import 'dart:developer';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:image_hasher_dart/image_hasher.dart';
import 'package:test/test.dart';

void main() {
  group(
    HashComparisonUtils,
    () {
      test(
        'HashComparisonUtils.compareHashes correctly calculates similarity',
        () {
          const resolution = 4;
          const depth = 4;
          const length = resolution * resolution;
          final hashA = ImageHash(resolution: resolution, depth: depth);
          final hashB = ImageHash(resolution: resolution, depth: depth);

          final List<int> cells = List.filled(
            (length - 1) * depth,
            1,
          );

          // hydrate hashes with identical data
          cells.forEachIndexed((index, element) {
            hashA.hashList[index] = element;
            hashB.hashList[index] = element;
          });

          // hydrate hashes with difference at last position
          hashA[15] = const HashPixel(r: 1, g: 1, b: 1, a: 1);
          hashB[15] = const HashPixel(r: 2, g: 2, b: 2, a: 2);

          final result = HashComparisonUtils.compareHashes(hashA, hashB);

          // ye im lazy as fuck
          expect(result, lessThan(1));
          expect(result, greaterThan(0.9));
        },
      );

      test(
        'HashComparisonUtils.areIdentical respects similarity',
        () {
          final stopWatch = Stopwatch()..start();
          const resolution = 2;
          const depth = 2;

          final fill = List.filled(16, 0);
          Uint8List unitsA = Uint8List.fromList(fill);
          Uint8List unitsB = Uint8List.fromList(fill);
          unitsB[9] = 1; // 1/16 difference
          final hashA = ImageHash(
            resolution: resolution,
            depth: depth,
            hashList: unitsA,
          );
          final hashB = ImageHash(
            resolution: resolution,
            depth: depth,
            hashList: unitsB,
          );

          // there is exactly 0.9375 percent of similarity
          final result = HashComparisonUtils.areIdentical(
            hashA,
            hashB,
            0.9,
          );

          log('Elapsed ${stopWatch.elapsedTicks}');
          stopWatch.stop();

          expect(result, true);
        },
      );
    },
  );
}
