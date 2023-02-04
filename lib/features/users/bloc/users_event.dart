part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UsersEvent {
  final String email;

  const LoadUsers({required this.email});

  @override
  List<Object> get props => [email];
}
