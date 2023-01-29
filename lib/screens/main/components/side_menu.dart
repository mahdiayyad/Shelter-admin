import 'dart:collection';

import 'package:admin/controllers/Session.dart';
import 'package:admin/controllers/UserManager.dart';
import 'package:admin/screens/providers/lang_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_svg/flutter_svg.dart';

final firestoreItemProvider =
    StateProvider<QuerySnapshot<Map<String, dynamic>>?>((ref) {
  return null;
});

final otherFirestoreItemProvider =
    StateProvider<QuerySnapshot<Map<String, dynamic>>?>((ref) {
  return null;
});

final selectedItemProvider = StateProvider<String>((ref) {
  return Session.menus.first;
});

final lastestIdProvider = StateProvider<String>((ref) {
  Map m = ref.watch(tableDataProvider);
  List _list = m[m.keys.first];
  int id = 0;
  _list.forEach((element) {
    if (int.tryParse(element['id'])! > id) {
      id = int.tryParse(element['id'])!;
    }
  });
  return (++id).toString();
});

final selectedCellProvider = StateProvider<String>((ref) {
  return '1';
});
final selectedTapleCellProvider = StateProvider<Map<String, dynamic>>((ref) {
  final table = ref.watch(tableDataProvider);
  final id = ref.watch(selectedCellProvider);

  //  final lang = ref.watch(langProvider);
  List list = table[table.keys.first];
  Map l = list.firstWhere((element) => element['id'] == id);
  print(l);
  return SplayTreeMap<String, dynamic>.from(l);
});
final tableDataProvider = StateProvider<Map<String, dynamic>>((ref) {
  var si = ref.watch(selectedItemProvider);
  final firestore = ref.watch(firestoreItemProvider);

  // ignore: unnecessary_null_comparison
  if (firestore != null) {
    var p = firestore.docs.firstWhere((element) => element.id == si).data();
    // print(p);
    return SplayTreeMap<String, dynamic>.from(p);
  } else
    return SplayTreeMap<String, dynamic>.from({});
});
final othertableDataProvider = StateProvider<Map<String, dynamic>>((ref) {
  var si = ref.watch(selectedItemProvider);
  final _ = ref.watch(langProvider);
  final firestore = ref.watch(otherFirestoreItemProvider);

  // ignore: unnecessary_null_comparison
  if (firestore != null) {
    var p = firestore.docs.firstWhere((element) => element.id == si).data();
    // print(p);
    return p;
  } else
    return {};
});

final menuWidgetsProvider = StateProvider<List<Widget>>((ref) {
  var i = ref.watch(selectedItemProvider);
  // var i = ref.read(selectedItemProvider).state;
  List<Widget> w = [
    DrawerHeader(
      child: Image.asset("assets/images/logo.png"),
    ),
  ];
  for (var item in Session.menus) {
    w.add(DrawerListTile(
      title: item,
      isSelected: i == item,
      svgSrc: "assets/icons/menu_dashbord.svg",
      press: () {
        ref.read(selectedItemProvider.state).state = item;
      },
    ));
  }
  w.add(TextButton(
    onPressed: () {
      UserManager().logout();
    },
    child: Text('Logout'),
  ));
  return w;
});

class SideMenu extends ConsumerWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var menus = ref.watch(menuWidgetsProvider);
    return Drawer(
      child: ListView(
        children: menus,
      ),
    );
  }

  // List<Widget> menus(BuildContext context) {
  //   var i = ref.read(selectedItemProvider).state;
  //   List<Widget> w = [
  //     DrawerHeader(
  //       child: Image.asset("assets/images/logo.png"),
  //     ),
  //   ];
  //   for (var item in Session.menus) {
  //     w.add(DrawerListTile(
  //       title: item,
  //       isSelected: i == item,
  //       svgSrc: "assets/icons/menu_dashbord.svg",
  //       press: () {
  //         i = item;
  //       },
  //     ));
  //   }
  //   return w;
  // }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.isSelected,
  }) : super(key: key);

  final String title, svgSrc;
  final bool isSelected;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      selectedTileColor: Colors.lightBlue,
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
