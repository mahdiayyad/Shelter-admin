// import 'package:get/get.dart';

import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/providers/posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'CusTable.dart';

class RecentFiles extends ConsumerWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var columns = ref.watch(tablecolumnProvider);
    // var rows = ref.watch(rowWidgetsProvider);
    var selectedItem = ref.watch(selectedItemProvider);

    switch (selectedItem) {
      case 'users':
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CusTable(clinicsRefPovider),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CusTable(storesRefPovider),
            ),
          ],
        );
      case 'posts':
        return CusTable(postsRefPovider);
      case 'items':
        return CusTable(itemsRefPovider);
      case 'pets':
        return CusTable(petsRefPovider);
      default:
        return CusTable(petsRefPovider);
    }
  }
}
