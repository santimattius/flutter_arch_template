import 'package:dartz/dartz.dart';
import 'package:flutter_arch_template/features/home/data/datasources/local_data_source.dart';
import 'package:flutter_arch_template/features/home/data/datasources/remote_data_source.dart';
import 'package:flutter_arch_template/features/home/data/repositories/pictures_repository_impl.dart';
import 'package:flutter_arch_template/features/home/domain/entities/picture.dart';
import 'package:flutter_arch_template/shared/error/exceptions.dart';
import 'package:flutter_arch_template/shared/error/failures.dart';
import 'package:flutter_arch_template/shared/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../picture_model_mother.dart';

class MockRemoteDataSource extends Mock implements PicturesRemoteDataSource {}

class MockLocalDataSource extends Mock implements PicturesLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  PicturesRepositoryImpl repository;

  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = PicturesRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getPictures', () {
    final tPicturesModels = PictureModelMother.generate();
    final List<Picture> tPictures = tPicturesModels;

    test('should che if device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getPictures();

      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should  return remote data when the call to remote data source is success',
          () async {
        when(mockRemoteDataSource.getPictures())
            .thenAnswer((_) async => tPicturesModels);

        final result = await repository.getPictures();

        verify(mockRemoteDataSource.getPictures());
        expect(result, equals(Right(tPictures)));
      });

      test(
          'should  cache th data locally data when the call to remote data source is success',
          () async {
        when(mockRemoteDataSource.getPictures())
            .thenAnswer((_) async => tPicturesModels);

        await repository.getPictures();

        verify(mockRemoteDataSource.getPictures());
        verify(mockLocalDataSource.cache(tPicturesModels));
      });

      test(
          'should  return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource.getPictures()).thenThrow(ServerException());

        final result = await repository.getPictures();

        verify(mockRemoteDataSource.getPictures());

        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data whe the cached data is present',
          () async {
        when(mockLocalDataSource.getAll())
            .thenAnswer((_) async => tPicturesModels);

        final result = await repository.getPictures();

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getAll());
        expect(result, equals(Right(tPictures)));
      });

      test('should return CacheFailure when there isno cached data present',
          () async {
        when(mockLocalDataSource.getAll()).thenThrow(CacheException());

        final result = await repository.getPictures();

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getAll());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
