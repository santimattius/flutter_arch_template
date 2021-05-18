import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_arch_template/features/pictures/domain/entities/picture.dart';
import 'package:flutter_arch_template/features/pictures/domain/usecases/get_pictures.dart';
import 'package:flutter_arch_template/shared/error/failures.dart';
import 'package:flutter_arch_template/shared/usecases/usecase.dart';
import 'package:meta/meta.dart';

import 'home_pictures_event.dart';
import 'home_pictures_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class HomePicturesBloc extends Bloc<HomeEvent, HomeState> {
  final GetPictures getPictures;

  HomePicturesBloc({
    // Changed the name of the constructor parameter (cannot use 'this.')
    @required GetPictures pictures,
    // Asserts are how you can make sure that a passed in argument is not null.
    // We omit this elsewhere for the sake of brevity.
  })  : assert(pictures != null),
        getPictures = pictures,
        super(Init());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    // Immediately branching the logic with type checking, in order
    // for the event to be smart casted
    if (event is GetPicturesEvent) {
      yield Loading();
      final failureOrPictures = await getPictures(
        NoParams(),
      );
      yield* _eitherLoadedOrErrorState(failureOrPictures);
    }
  }

  Stream<HomeState> _eitherLoadedOrErrorState(
    Either<Failure, List<Picture>> either,
  ) async* {
    yield either.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (pictures) => Loaded(pictures: pictures),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
