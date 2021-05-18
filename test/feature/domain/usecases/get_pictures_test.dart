import 'package:dartz/dartz.dart';
import 'package:flutter_arch_template/features/pictures/domain/repositories/pictures_repository.dart';
import 'package:flutter_arch_template/features/pictures/domain/usecases/get_pictures.dart';
import 'package:flutter_arch_template/shared/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../picture_mother.dart';

class MockPicturesRepository extends Mock implements PicturesRepository {}

void main() {
  GetPictures usecase;
  MockPicturesRepository mockPicturesRepository;

  setUp(() {
    mockPicturesRepository = MockPicturesRepository();
    usecase = GetPictures(mockPicturesRepository);
  });

  final tPictures = PictureMother.generate();

  test(
    'should get pictures from the repository',
    () async {
      when(mockPicturesRepository.getPictures())
          .thenAnswer((_) async => Right(tPictures));

      final result = await usecase(NoParams());

      expect(result, Right(tPictures));
      verify(mockPicturesRepository.getPictures());
      verifyNoMoreInteractions(mockPicturesRepository);
    },
  );
}
