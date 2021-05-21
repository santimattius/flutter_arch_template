import 'package:dartz/dartz.dart';
import 'package:flutter_arch_template/features/home/domain/usecases/get_pictures.dart';
import 'package:flutter_arch_template/features/home/presentation/bloc/home_pictures_bloc.dart';
import 'package:flutter_arch_template/features/home/presentation/bloc/home_pictures_event.dart';
import 'package:flutter_arch_template/features/home/presentation/bloc/home_pictures_state.dart';
import 'package:flutter_arch_template/shared/error/failures.dart';
import 'package:flutter_arch_template/shared/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../domain/picture_mother.dart';

class MockGetPictures extends Mock implements GetPictures {}

void main() {
  HomePicturesBloc bloc;
  MockGetPictures mockGetPictures;

  setUp(() {
    mockGetPictures = MockGetPictures();

    bloc = HomePicturesBloc(
      pictures: mockGetPictures,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(Init()));
  });

  group('getPictures', () {
    final tPictures = PictureMother.generate();

    test(
      'should get data from the get pictures use case',
      () async {
        // arrange
        when(mockGetPictures(any)).thenAnswer((_) async => Right(tPictures));
        // act
        bloc.add(GetPicturesEvent());
        await untilCalled(mockGetPictures(any));
        // assert
        verify(mockGetPictures(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetPictures(any)).thenAnswer((_) async => Right(tPictures));
        // assert later
        final expected = [
          Loading(),
          Loaded(pictures: tPictures),
        ];
        // act
        bloc.add(GetPicturesEvent());
        // assert
        await expectLater(bloc.stream, emitsInOrder(expected));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockGetPictures(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        // act
        bloc.add(GetPicturesEvent());
        //assert
        await expectLater(bloc.stream, emitsInOrder(expected));
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        // arrange
        when(mockGetPictures(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        // act
        bloc.add(GetPicturesEvent());
        // assert
        await expectLater(bloc.stream, emitsInOrder(expected));
      },
    );
  });
}
