import 'package:admin/controllers/MenuController.dart';
import 'package:admin/controllers/Session.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/side_menu.dart';

class MainScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(otherCollectionProvider);

    List<String> l = ['users', 'posts', 'items', 'pets'];

    Session.menus = l;

    return Scaffold(
      key: ref.read(menuStateProvider),
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      //   FirebaseFirestore fbFirestore = FirebaseFirestore.instance;
      //   var d = await fbFirestore.doc('website_body/projects').get();
      //   Map<String, dynamic> data = d.data()!;
      //   // print(data);
      //   await fbFirestore.doc('body/Projects').update(data);
      // }),
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
    //   }

    // loading: () {
    //   return Scaffold(
    //     // key: ref.read(menuStateProvider),
    //     // drawer: SideMenu(),
    //     body: SafeArea(
    //       child: Center(
    //         child: Text("Loading....."),
    //       ),
    //     ),
    //   );
    // },
    // error: (error, stackTrace) {
    //   return Scaffold(
    //     // drawer: SideMenu(),
    //     // key: ref.read(menuStateProvider),
    //     body: SafeArea(
    //       child: Center(
    //         child: Text("Erorr....."),
    //       ),
    //     ),
    //   );
    // },
    // );
  }

  Future<void> preLoad(BuildContext ctx) async {
    // var db = await FirebaseFirestore.instance.collection('website_body').get();

    return;
  }
}
