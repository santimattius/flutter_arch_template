import 'package:flutter_arch_template/features/pictures/data/datasources/remote_data_source.dart';
import 'package:flutter_arch_template/features/pictures/data/models/picture_model.dart';
import 'package:flutter_arch_template/shared/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  PicturesRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = PicturesRemoteDataSourceImpl(client: mockHttpClient);
  });

  const _URL = 'https://pictures.getsandbox.com:443/pictures';

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('data.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getPictures', () {
    final tPictureModel = fromJson(fixture('data.json'));

    test('''should perform a GET request on a URL with number 
    being the endpoint and with application/json header''', () async {
      setUpMockHttpClientSuccess200();
      dataSource.getPictures();

      verify(mockHttpClient
          .get(Uri.parse(_URL), headers: {'Content-Type': 'application/json'}));
    });

    test(
        'should return list of pictures when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getPictures();

      expect(result, equals(tPictureModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setUpMockHttpClientFailure404();

      final call = dataSource.getPictures;

      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
