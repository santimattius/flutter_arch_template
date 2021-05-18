import 'dart:math';

import 'package:flutter_arch_template/features/pictures/data/models/picture_model.dart';

abstract class PictureModelMother {
  static List<PictureModel> generate() =>
      List.generate(10, (index) => create());

  static PictureModel create() => PictureModel(
      id: "${TestingHelper.randomNumber()}",
      author: TestingHelper.getRandomString(20),
      width: TestingHelper.randomNumber(),
      height: TestingHelper.randomNumber(),
      url: TestingHelper.getRandomString(20),
      downloadUrl: TestingHelper.getRandomString(20));

  static PictureModel createSingle() => PictureModel(
      id: "0",
      author: "Alejandro Escamilla",
      width: 5616,
      height: 3744,
      url: "https://unsplash.com/photos/yC-Yzbqy7PY",
      downloadUrl: "https://picsum.photos/id/0/5616/3744");
}

abstract class TestingHelper {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  static int randomNumber() {
    final random = Random();
    return random.nextInt(100);
  }

  static String getRandomString(int length) {
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(random.nextInt(_chars.length))));
  }
}
