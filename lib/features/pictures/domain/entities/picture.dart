import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Picture extends Equatable {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  Picture({
    @required this.id,
    @required this.author,
    @required this.width,
    @required this.height,
    @required this.url,
    @required this.downloadUrl,
  }) : super();

  @override
  List<Object> get props => [id, author, width, height, url, downloadUrl];
}
