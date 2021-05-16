import 'package:flutter_arch_template/features/pictures/data/datasources/local_data_source.dart';
import 'package:flutter_arch_template/features/pictures/data/models/picture_model.dart';
import 'package:flutter_arch_template/shared/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_reader.dart';
import '../picture_model_mother.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  SharedPreferencesLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = SharedPreferencesLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getAllPictures', () {
    final pictures = fromJson(fixture('data.json'));
    test(
        'should return list of pictures from SharedPreferences when there is one in the cache',
        () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('data.json'));

      final result = await dataSource.getAll();

      verify(mockSharedPreferences.getString(CACHED_PICTURES));
      expect(result, equals(pictures));
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = dataSource.getAll;

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cache', () {
    final tPictureModel = PictureModelMother.generate();

    test('should call SharedPreferences to cache the data', () async {
      dataSource.cache(tPictureModel);
      final expectedJsonString = toJson(tPictureModel);

      verify(
          mockSharedPreferences.setString(CACHED_PICTURES, expectedJsonString));
    });
  });
}
