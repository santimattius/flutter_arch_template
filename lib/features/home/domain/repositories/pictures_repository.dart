import 'package:dartz/dartz.dart';
import 'package:flutter_arch_template/features/home/domain/entities/picture.dart';
import 'package:flutter_arch_template/shared/error/failures.dart';

abstract class PicturesRepository {
  Future<Either<Failure, List<Picture>>> getPictures();
}
