import 'dart:convert';

import 'package:flutter_arch_template/features/pictures/data/models/picture_model.dart';
import 'package:flutter_arch_template/features/pictures/domain/entities/picture.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';
import '../picture_model_mother.dart';

void main() {
  final tPictureModel = PictureModelMother.createSingle();

  test('should be a subclass of Picture entity', () async {
    expect(tPictureModel, isA<Picture>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('picture.json'));

      final result = PictureModel.fromJson(jsonMap);

      expect(result, tPictureModel);
    });
  });

  group('toJson', () {
    test('should return as Json map containing the proper data', () async {
      final result = tPictureModel.toJson();

      final expectedMap = {
        "id": "0",
        "author": "Alejandro Escamilla",
        "width": 5616,
        "height": 3744,
        "url": "https://unsplash.com/photos/yC-Yzbqy7PY",
        "download_url": "https://picsum.photos/id/0/5616/3744"
      };
      expect(result, expectedMap);
    });
  });
}
