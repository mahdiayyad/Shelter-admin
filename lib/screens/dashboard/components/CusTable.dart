import 'dart:collection';
import 'package:admin/controllers/Application.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../constants.dart';

class CusTable extends ConsumerWidget {
  const CusTable(
    this.provider, {
    Key? key,
  }) : super(key: key);
  final StateProvider<Query<Map<String, dynamic>>> provider;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Error');
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );

              default:
                var docs = snapshot.data?.docs;
                QueryDocumentSnapshot<Map<String, dynamic>>? doc = docs?.first;
                print(snapshot.error);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "clinics",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: DataTable2(
                        onSelectAll: (value) {
                          print(value);
                        },
                        columnSpacing: defaultPadding,
                        minWidth: 600,

                        // dataRowHeight: 200,
                        columns: getCoulmns(doc?.data()),
                        rows: getRows(docs),
                      ),
                    ),
                  ],
                );
            }
          },
          stream: ref.read(provider).snapshots()),
    );
  }

  List<DataColumn> getCoulmns(Map? i) {
    if (i == null) {
      return [];
    }
    List<DataColumn> w = [];
    final sorted = new SplayTreeMap<String, dynamic>.from(i);
    if (sorted.keys.length > 1) {
      for (var item in sorted.keys) {
        w.add(
          DataColumn(
            label: Text(item.toString()),
          ),
        );
      }
    }

    return w;
  }

  getRows(
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs,
  ) {
    if (docs == null) {
      return [];
    }

    // var oColl = ref.watch(otherCollectionAddressProvider).state;
    // var collection = ref.watch(collectionProvider);
    // Map<String, dynamic> otherMapState = ref.watch(othertableDataProvider).state;
    // var i = ref.read(selectedItemProvider).state;
    List<DataRow> w = [];

    for (int i = 0; i < docs.length; i++) {
      var doc = docs[i];
      Map<String, dynamic> item = doc.data();

      final sorted = new SplayTreeMap<String, dynamic>.from(item);
      w.add(
        DataRow(
          cells: getcells(sorted, onChange: (value, key) async {
            doc.reference.update({key: value});
          }),
        ),
      );
    }
    // }
    return w;
  }

  List<DataCell> getcells(
    Map map, {
    Function(bool?, String)? onChange,
  }) {
    List<DataCell> w = [];
    // BuildContext context =
    //     application.appRouter!.navigatorKey.currentState!.overlay!.context;
    for (var item in map.entries) {
      String text;
      // if (item.key.toString().startsWith('tr_')) {
      //   // text = translateFromFB(item.key, context);
      //   text = translateFromFB(item.value, context);
      // } else {
      text = item.value.toString();
      // }
      print(text);
      w.add(
        DataCell(
          Padding(
            padding: EdgeInsets.all(8),
            child: (text == "true" || text == "false")
                ? Checkbox(
                    value: text == 'true',
                    onChanged: (v) {
                      onChange!.call(v, item.key);
                    },
                  )
                : Text(text),
          ),
          onTap: () async {
            application.launchURL(url: item.value);
          },
        ),
      );

      // mainAxisSize: MainAxisSize.min,

    }
    return w;
  }
}
