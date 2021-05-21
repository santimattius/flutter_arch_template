import 'package:dartz/dartz.dart';
import 'package:flutter_arch_template/features/home/data/datasources/local_data_source.dart';
import 'package:flutter_arch_template/features/home/data/datasources/remote_data_source.dart';
import 'package:flutter_arch_template/features/home/domain/entities/picture.dart';
import 'package:flutter_arch_template/features/home/domain/repositories/pictures_repository.dart';
import 'package:flutter_arch_template/shared/error/exceptions.dart';
import 'package:flutter_arch_template/shared/error/failures.dart';
import 'package:flutter_arch_template/shared/network/network_info.dart';
import 'package:meta/meta.dart';

class PicturesRepositoryImpl implements PicturesRepository {
  final PicturesRemoteDataSource remoteDataSource;
  final PicturesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PicturesRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, List<Picture>>> getPictures() async {
    return await _getPictures(() async => await remoteDataSource.getPictures());
  }

  Future<Either<Failure, List<Picture>>> _getPictures(
      Future<List<Picture>> Function() call) async {
    if (await networkInfo.isConnected) {
      try {
        var remotePictures = await call();
        localDataSource.cache(remotePictures);
        return Right(remotePictures);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        var localPictures = await localDataSource.getAll();
        return Right(localPictures);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
