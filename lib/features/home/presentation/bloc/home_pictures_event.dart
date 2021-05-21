import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  final List _props;

  HomeEvent([this._props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => _props;
}

class GetPicturesEvent extends HomeEvent {}
