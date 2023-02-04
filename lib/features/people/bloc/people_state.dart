part of 'people_bloc.dart';

abstract class PeopleState extends Equatable {
  const PeopleState();

  @override
  List<Object> get props => [];
}

class PeopleLoading extends PeopleState {}

class PeopleValidated extends PeopleState {
  final People people;

  const PeopleValidated({required this.people});

  @override
  List<Object> get props => [people];
}

class PeopleLoaded extends PeopleState {
  final List<People> people;

  const PeopleLoaded({
    this.people = const [],
  });

  @override
  List<Object> get props => [people];
}

class PeopleDeleted extends PeopleState {
  final String email;

  const PeopleDeleted({required this.email});

  @override
  List<Object> get props => [email];
}

class PeopleUpdated extends PeopleState {
  final People people;

  const PeopleUpdated({required this.people});

  @override
  List<Object> get props => [people];
}
