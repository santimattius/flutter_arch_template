import 'package:equatable/equatable.dart';
import 'package:flutter_arch_template/features/pictures/domain/entities/picture.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  final List _props;

  HomeState([this._props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => _props;
}

class Init extends HomeState {}

class Empty extends HomeState {}

class Loading extends HomeState {}

class Loaded extends HomeState {
  final List<Picture> pictures;

  Loaded({@required this.pictures}) : super([pictures]);
}

class Error extends HomeState {
  final String message;

  Error({@required this.message}) : super([message]);
}
