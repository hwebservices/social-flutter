import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories.dart';

part 'members_state.dart';

class MembersCubit extends Cubit<MembersState> {
  final PeopleRepository _peopleRepository;
  MembersCubit({required PeopleRepository peopleRepository})
      : _peopleRepository = peopleRepository,
        super(MembersLoading());

  void updateHot(String email, bool hot) {
    emit(MembersLoading());
    try {
      emit(MembersLoaded(email: email, hot: hot));
    } on Exception catch (e) {
      print('Error: $e');
      emit(MembersError(message: e.toString()));
    }
  }

  Future<void> updateBlocked(String email, bool blocked) async {
    emit(MembersLoading());
    try {
      await _peopleRepository.updateBlockedMember(
          email: email, blocked: blocked);
      emit(MembersLoaded(email: email, blocked: blocked));
    } on Exception catch (e) {
      print('Error: $e');
      emit(MembersError(message: e.toString()));
    }
  }

  Future<void> updateReported(String email, bool reported) async {
    emit(MembersLoading());
    try {
      await _peopleRepository.updateReportedMember(
          email: email, reported: reported);
      emit(MembersLoaded(email: email, reported: reported));
    } on Exception catch (e) {
      print('Error: $e');
      emit(MembersError(message: e.toString()));
    }
  }

  void listenToMembersChanges({required String email}) {
    emit(MembersLoading());
    try {} on Exception catch (e) {
      print('Error: $e');
      emit(MembersError(message: e.toString()));
    }
  }
}
