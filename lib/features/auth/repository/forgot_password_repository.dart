import 'package:social/services/firebase.dart';

import '../../repositories.dart';

class ForgotPasswordRepository extends BaseForgotPassword {
  @override
  Future<void> resetPassword(String email) async {
    await FirebaseServices.auth.sendPasswordResetEmail(email: email);
  }
}
