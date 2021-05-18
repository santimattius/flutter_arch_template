import 'package:dartz/dartz.dart';
import 'package:flutter_arch_template/features/pictures/domain/entities/picture.dart';
import 'package:flutter_arch_template/features/pictures/domain/repositories/pictures_repository.dart';
import 'package:flutter_arch_template/shared/error/failures.dart';
import 'package:flutter_arch_template/shared/usecases/usecase.dart';

class GetPictures implements UseCase<List<Picture>, NoParams> {
  final PicturesRepository repository;

  GetPictures(this.repository);

  @override
  Future<Either<Failure, List<Picture>>> call(NoParams params) async {
    return await repository.getPictures();
  }
}
