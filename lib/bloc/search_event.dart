import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchInfo extends SearchEvent {
  final _city;

  FetchInfo(this._city);

  @override
  // TODO: implement props
  List<Object> get props => [_city];
}

class ResetInfo extends SearchEvent {}