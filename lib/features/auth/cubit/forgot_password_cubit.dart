import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepository _forgotPasswordRepository;
  // ForgotPasswordCubit() : super(ForgotPassword());
  ForgotPasswordCubit({required ForgotPasswordRepository resetPassword})
      : _forgotPasswordRepository = resetPassword,
        super(ForgotPasswordState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: ForgotPasswordStatus.submitting));
  }

  void resetUserPassword() async {
    try {
      print('The email is ${state.email}');
      await _forgotPasswordRepository.resetPassword(state.email);
      emit(
        state.copyWith(status: ForgotPasswordStatus.success, error: 'no-error'),
      );
      print('On SUCCESS ${state.error}');
    } on FirebaseAuthException catch (e) {
      print('Error from Cubit ${state.error}');
      emit(
          state.copyWith(status: ForgotPasswordStatus.error, error: e.message));
    }
  }
}
