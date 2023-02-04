part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final User user;
  const UsersLoaded({required this.user});

  @override
  List<Object> get props => [user];
}
