part of 'members_cubit.dart';

class MembersState extends Equatable {
  const MembersState();

  @override
  List<Object> get props => [];
}

class MembersLoading extends MembersState {}

class MembersLoaded extends MembersState {
  final String email;
  final bool? hot;
  final bool? blocked;
  final bool? reported;

  const MembersLoaded({
    required this.email,
    this.hot,
    this.blocked,
    this.reported,
  });

  @override
  List<Object> get props => [email, hot!, blocked!, reported!];
}

class MembersError extends MembersState {
  final String message;

  const MembersError({required this.message});

  @override
  List<Object> get props => [message];
}
