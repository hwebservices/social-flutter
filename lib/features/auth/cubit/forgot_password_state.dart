part of 'forgot_password_cubit.dart';

enum ForgotPasswordStatus { initial, submitting, success, error }

class ForgotPasswordState extends Equatable {
  final String email;
  String? error;
  final ForgotPasswordStatus status;

  bool get isEmailValid => email.isNotEmpty;

  ForgotPasswordState({
    required this.email,
    this.error,
    required this.status,
  });

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      email: '',
      error: 'Is the email correct? Try again please...',
      status: ForgotPasswordStatus.submitting,
    );
  }
  @override
  bool get stringify => true;

  @override
  List<Object> get props => [email, error!, status];

  ForgotPasswordState copyWith({
    String? email,
    String? error,
    ForgotPasswordStatus? status,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
