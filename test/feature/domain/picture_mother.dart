import 'package:flutter_arch_template/features/pictures/domain/entities/picture.dart';

import '../data/picture_model_mother.dart';

abstract class PictureMother {
  static List<Picture> generate() => List.generate(10, (index) => create());

  static Picture create() => Picture(
      id: "${TestingHelper.randomNumber()}",
      author: TestingHelper.getRandomString(20),
      width: TestingHelper.randomNumber(),
      height: TestingHelper.randomNumber(),
      url: TestingHelper.getRandomString(20),
      downloadUrl: TestingHelper.getRandomString(20));
}
