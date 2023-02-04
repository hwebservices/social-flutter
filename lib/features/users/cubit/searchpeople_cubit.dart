import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories.dart';

part 'searchpeople_state.dart';

class SearchPeopleCubit extends Cubit<SearchpeopleState> {
  final PeopleRepository _peopleRepository;

  SearchPeopleCubit({required PeopleRepository peopleRepository})
      : _peopleRepository = peopleRepository,
        super(SearchpeopleState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SearchPeopleStatus.submitting));
  }

  void searchPeople() async {
    try {
      await _peopleRepository.searchPeople(email: state.email);
      print('The email is ${state.email}');
      emit(state.copyWith(
          status: SearchPeopleStatus.success, error: 'no-error'));
      print('On SUCCESS ${state.error}');
    } catch (e) {
      print(e);
    }
  }
}
