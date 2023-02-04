part of 'searchpeople_cubit.dart';

enum SearchPeopleStatus { initial, submitting, success, error }

class SearchpeopleState extends Equatable {
  final String email;
  String? error;
  final SearchPeopleStatus status;
  SearchpeopleState({
    required this.email,
    required this.status,
    this.error,
  });

  factory SearchpeopleState.initial() {
    return SearchpeopleState(
      email: '',
      error: 'error..',
      status: SearchPeopleStatus.submitting,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [email, error!, status];

  SearchpeopleState copyWith({
    String? email,
    String? error,
    SearchPeopleStatus? status,
  }) {
    return SearchpeopleState(
      email: email ?? this.email,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
