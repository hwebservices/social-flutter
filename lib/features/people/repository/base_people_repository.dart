import '../../users/model/user.dart';
import '../model/people.dart';

abstract class BasePeopleRepository {
  Future<People> searchPeople({required String email});
  Future<User> getPeople({required String email});
  Future<List<People>> getHunting();
  Future<People> getMember({required String email});
  Future<void> deletePeople({required String email});
  Future<void> updateHotMember({required String email, required bool hot});
  Stream<People?> statusMember({required String email});
  Future<void> updateBlockedMember(
      {required String email, required bool blocked});
  Future<void> updateReportedMember(
      {required String email, required bool reported});
}
