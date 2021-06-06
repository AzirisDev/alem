import 'package:alem/src/city_model.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class IsNotSearched extends SearchState {}

class IsLoading extends SearchState {}

class IsLoaded extends SearchState {
  final CityModel _info;

  IsLoaded(this._info);

  CityModel get getInfo => _info;

  @override
  List<Object> get props => [_info];
}

class IsNotLoaded extends SearchState {}
