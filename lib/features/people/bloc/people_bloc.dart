import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../blocs.dart';
import '../../repositories.dart';
import '../model/people.dart';
import '../pages/people/people_list.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final AuthBloc _authBloc;
  final PeopleRepository _peopleRepository;
  StreamSubscription? _authSubscription;

  PeopleBloc({
    required AuthBloc authBloc,
    required PeopleRepository peopleRepository,
  })  : _authBloc = authBloc,
        _peopleRepository = peopleRepository,
        super(PeopleLoading()) {
    on<ValidatePeople>(_onValidatePeople);
    on<LoadPeople>(_onLoadPeople);
    on<DeletePeople>(_onDeletePeople);
    on<UpdatePeople>(_onUpdatePeople);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user != null) {
        add(LoadPeople(userId: state.user!.uid));
      }
    });
  }

  Future<void> _onValidatePeople(
      ValidatePeople event, Emitter<PeopleState> emit) async {
    final people = await _peopleRepository.searchPeople(email: event.email);
    print('The USER found is:::: $people');
    emit(PeopleValidated(people: people));
  }

  Future<void> _onLoadPeople(
      LoadPeople event, Emitter<PeopleState> emit) async {
    final data = await _peopleRepository.getHunting();
    print('The BLOC PEOPLE is: $data');
    emit(PeopleLoaded(people: data));
  }

  Future<void> _onDeletePeople(
      DeletePeople event, Emitter<PeopleState> emit) async {
    await _peopleRepository.deletePeople(email: event.email);
    emit(const PeopleDeleted(email: ''));
  }

  Future<void> _onUpdatePeople(
      UpdatePeople event, Emitter<PeopleState> emit) async {
    final people = await _peopleRepository.getMember(email: event.email);
    emit(PeopleUpdated(people: people));
  }
}
