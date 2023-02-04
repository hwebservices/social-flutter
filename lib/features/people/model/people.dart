import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class People extends Equatable {
  String? email;
  String? username;
  String? persona;
  String? reason;
  bool? blocked;
  bool? reported;
  bool? hot;

  People({
    this.email,
    this.username,
    this.persona,
    this.reason,
    this.blocked,
    this.reported,
    this.hot,
  });

  @override
  List<Object?> get props => [
        email,
        username,
        persona,
        reason,
        blocked,
        reported,
        hot,
      ];

  factory People.fromSnapshot(DocumentSnapshot snapshot) {
    return People(
      email: snapshot['email'] != null ? snapshot['email'] as String : null,
      username:
          snapshot['username'] != null ? snapshot['username'] as String : null,
      persona:
          snapshot['persona'] != null ? snapshot['persona'] as String : null,
      reason: snapshot['reason'] != null ? snapshot['reason'] as String : null,
      blocked: snapshot['blocked'] != null ? snapshot['blocked'] as bool : null,
      reported:
          snapshot['reported'] != null ? snapshot['reported'] as bool : null,
      hot: snapshot['hot'] != null ? snapshot['hot'] as bool : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'persona': persona,
      'reason': reason,
      'blocked': blocked,
      'reported': reported,
      'hot': hot,
    };
  }
}
