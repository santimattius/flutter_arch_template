import 'package:flutter_arch_template/features/home/data/models/picture_model.dart';
import 'package:flutter_arch_template/shared/error/exceptions.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PicturesLocalDataSource {
  /// Gets the cached [PictureModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<List<PictureModel>> getAll();

  Future<void> cache(List<PictureModel> pictures);
}

const CACHED_PICTURES = 'cached_pictures';

class SharedPreferencesLocalDataSourceImpl implements PicturesLocalDataSource {
  final SharedPreferences sharedPreferences;

  SharedPreferencesLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<List<PictureModel>> getAll() {
    final jsonString = sharedPreferences.getString(CACHED_PICTURES);
    if (jsonString == null) {
      throw CacheException();
    } else {
      return Future.value(fromJson(jsonString));
    }
  }

  @override
  Future<void> cache(List<PictureModel> pictures) {
    return sharedPreferences.setString(CACHED_PICTURES, toJson(pictures));
  }
}
