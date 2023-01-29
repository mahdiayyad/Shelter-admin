import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postsRefPovider = StateProvider<Query<Map<String, dynamic>>>((ref) {
  var resRef = FirebaseFirestore.instance
      .collection("posts")
      .orderBy("is_approved", descending: true);
  return resRef;
});
final clinicsRefPovider = StateProvider<Query<Map<String, dynamic>>>((ref) {
  var resRef = FirebaseFirestore.instance
      .collection("users")
      .orderBy("is_approved", descending: true)
      .where("userType", isEqualTo: 'clinic');
  return resRef;
});
final storesRefPovider = StateProvider<Query<Map<String, dynamic>>>((ref) {
  var resRef = FirebaseFirestore.instance
      .collection("users")
      .orderBy("is_approved", descending: true)
      .where("userType", isEqualTo: 'store');
  return resRef;
});

final itemsRefPovider = StateProvider<Query<Map<String, dynamic>>>((ref) {
  var resRef = FirebaseFirestore.instance
      .collection("items")
      .orderBy("is_approved", descending: true);
  return resRef;
});
final petsRefPovider = StateProvider<Query<Map<String, dynamic>>>((ref) {
  var resRef = FirebaseFirestore.instance
      .collection("pets")
      .orderBy("is_approved", descending: true);
  return resRef;
});
final itemsRefUidPovider =
    StateProvider.family<Query<Map<String, dynamic>>, String?>((ref, uid) {
  var resRef = FirebaseFirestore.instance
      .collection("items")
      .orderBy("timestamp", descending: true)
      .where("is_approved", isEqualTo: true)
      .where("userId", isEqualTo: uid);
  return resRef;
});
final petsRefUidPovider =
    StateProvider.family<Query<Map<String, dynamic>>, String?>((ref, uid) {
  var resRef = FirebaseFirestore.instance
      .collection("pets")
      .orderBy("timestamp", descending: true)
      .where("is_approved", isEqualTo: true)
      .where("userId", isEqualTo: uid);
  return resRef;
});
