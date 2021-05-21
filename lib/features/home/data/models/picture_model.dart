import 'dart:convert';

import 'package:flutter_arch_template/features/home/domain/entities/picture.dart';
import 'package:meta/meta.dart';

List<PictureModel> fromJson(String str) => List<PictureModel>.from(
    json.decode(str).map((x) => PictureModel.fromJson(x)));

String toJson(List<PictureModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PictureModel extends Picture {
  PictureModel({
    @required id,
    @required author,
    @required width,
    @required height,
    @required url,
    @required downloadUrl,
  }) : super(
            id: id,
            author: author,
            width: width,
            height: height,
            url: url,
            downloadUrl: downloadUrl);

  factory PictureModel.fromJson(Map<String, dynamic> json) => PictureModel(
        id: json["id"],
        author: json["author"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        downloadUrl: json["download_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "width": width,
        "height": height,
        "url": url,
        "download_url": downloadUrl,
      };
}
