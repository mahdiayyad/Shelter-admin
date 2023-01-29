import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuStateProvider =
    StateNotifierProvider<MenuNotifier, GlobalKey<ScaffoldState>>((ref) {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  return MenuNotifier(_scaffoldKey);
});

class MenuNotifier extends StateNotifier<GlobalKey<ScaffoldState>> {
  MenuNotifier(_scaffoldKey) : super(_scaffoldKey);

  void controlMenu() {
    if (!this.state.currentState!.isDrawerOpen) {
      this.state.currentState!.openDrawer();
    }
  }
}

// class MenuController extends ChangeNotifier {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

//   void controlMenu() {
//     if (!_scaffoldKey.currentState!.isDrawerOpen) {
//       _scaffoldKey.currentState!.openDrawer();
//     }
//   }
// }
