import 'package:admin/screens/main/components/side_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final langProvider = StateProvider<Locale>((ref) {
  return Locale('en');
});

final collectionAddressProvider =
    StateProvider<CollectionReference<Map<String, dynamic>>>((ref) {
  // final i = ref.watch(langProvider);

  var db = FirebaseFirestore.instance.collection('body');
  return db;
});
final langAddressProvider =
    StateProvider<QuerySnapshot<Map<String, dynamic>>?>((ref) {
  return null;
});
final langdocAddressProvider =
    StateProvider<QueryDocumentSnapshot<Map<String, dynamic>>?>((ref) {
  var l = ref.watch(langProvider);
  var langAddress = ref.watch(langAddressProvider);
  return langAddress?.docs
      .firstWhere((element) => element.id == l.toLanguageTag());
});
final langMapProvider = StateProvider<Map<String, dynamic>?>((ref) {
  var l = ref.watch(langdocAddressProvider);

  return l?.data() ?? {};
});

final langCollectionAddressProvider =
    StateProvider<CollectionReference<Map<String, dynamic>>>((ref) {
  // final i = ref.watch(langProvider);

  var db = FirebaseFirestore.instance.collection('languages');
  return db;
});
// final otherCollectionAddressProvider =
//     StateProvider<CollectionReference<Map<String, dynamic>>>((ref) {
//   final i = ref.watch(langProvider);

//   var db = FirebaseFirestore.instance.collection(
//       i.state.toLanguageTag() == 'en' ? 'website_body_ar' : 'body');
//   return db;
// });

final collectionProvider =
    FutureProvider<QuerySnapshot<Map<String, dynamic>>>((ref) async {
  final c = ref.watch(collectionAddressProvider);
  final lan = ref.watch(langCollectionAddressProvider);
  var db = await c.get();
  ref.read(firestoreItemProvider.state).state = db;
  var langdb = await lan.get();

  ref.read(langAddressProvider.state).state = langdb;
  print(langdb.docs.first.id);
  return db;
});
