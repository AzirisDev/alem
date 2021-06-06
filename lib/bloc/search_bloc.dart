import 'package:alem/bloc/search_event.dart';
import 'package:alem/bloc/search_state.dart';
import 'package:alem/repo/search_repo.dart';
import 'package:alem/src/city_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository searchRepo;

  SearchBloc(this.searchRepo) : super(IsNotSearched());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is FetchInfo) {
      yield IsLoading();
      try {
        CityModel cityModel = await searchRepo.getInfo(
            city: event.props[0].toString().toLowerCase());

        yield IsLoaded(cityModel);
      } catch (_) {
        yield IsNotLoaded();
      }
    } else if (event is ResetInfo) {
      yield IsNotSearched();
    }
  }
}
