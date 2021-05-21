import 'package:flutter_arch_template/features/home/data/models/picture_model.dart';
import 'package:flutter_arch_template/shared/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class PicturesRemoteDataSource {
  /// Calls the https://pictures.getsandbox.com:443/pictures endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PictureModel>> getPictures();
}

class PicturesRemoteDataSourceImpl implements PicturesRemoteDataSource {
  final http.Client client;

  PicturesRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<PictureModel>> getPictures() async {
    return _getPicturesUrl('https://pictures.getsandbox.com:443/pictures');
  }

  Future<List<PictureModel>> _getPicturesUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return fromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
