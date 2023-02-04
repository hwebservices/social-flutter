part of 'people_bloc.dart';

abstract class PeopleEvent extends Equatable {
  const PeopleEvent();

  @override
  List<Object> get props => [];
}

// class SavePeople extends PeopleEvent {
//   final People hunter;

//   const SavePeople({required this.hunter});

//   @override
//   List<Object> get props => [hunter];
// }

class ValidatePeople extends PeopleEvent {
  final String email;

  const ValidatePeople({required this.email});

  @override
  List<Object> get props => [email];
}

class LoadPeople extends PeopleEvent {
  final String userId;

  const LoadPeople({required this.userId});

  @override
  List<Object> get props => [userId];
}

class DeletePeople extends PeopleEvent {
  final String email;

  const DeletePeople({required this.email});

  @override
  List<Object> get props => [email];
}

class UpdatePeople extends PeopleEvent {
  final String email;

  const UpdatePeople({required this.email});

  @override
  List<Object> get props => [email];
}
