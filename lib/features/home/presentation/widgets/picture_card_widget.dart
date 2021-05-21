import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arch_template/features/home/domain/entities/picture.dart';

import 'loading_widget.dart';

class PictureCard extends StatefulWidget {
  final Picture picture;

  const PictureCard(
    this.picture, {
    Key key,
  }) : super(key: key);

  @override
  _PictureCardState createState() => _PictureCardState();
}

class _PictureCardState extends State<PictureCard> {
  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.picture.downloadUrl,
              placeholder: (context, url) => LoadingWidget(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Author: ${widget.picture.author}'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
