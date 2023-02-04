import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories.dart';
import '../model/user.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository _usersRepository;

  UsersBloc({
    required UsersRepository usersRepository,
  })  : _usersRepository = usersRepository,
        super(UsersLoading()) {
    on<LoadUsers>(_onLoadUsers);
  }

  Future<User> _onLoadUsers(LoadUsers event, Emitter<UsersState> emit) async {
    final user = await _usersRepository.getUsers(email: event.email);
    print('USERS BLOC: $user');
    emit(UsersLoaded(user: user));
    return user;
  }
}
