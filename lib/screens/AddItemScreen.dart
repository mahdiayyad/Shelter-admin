// import 'dart:collection';

// import 'package:admin/screens/dashboard/components/header.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:uuid/uuid.dart';

// import 'main/components/side_menu.dart';
// import 'providers/lang_provider.dart';

// class AddItemScreen extends ConsumerWidget {
//   final Map map;
//   // final String id;
//   const AddItemScreen({Key? key, required this.map}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var id = ref.watch(selectedItemProvider);
//     var coll = ref.watch(collectionAddressProvider);
//     var firestore = ref.watch(firestoreItemProvider);
//     var isUpdate = ref.watch(isUpdateProvider);

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 100,
//         title: Header(
//           tilte: 'Add Item',
//           withDrawer: false,
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: WillPopScope(
//         onWillPop: () {
//           ref.read(mapProvider.state).state = {};
//           return Future.value(true);
//         },
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Center(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     buildAddWidget(
//                       SplayTreeMap<String, dynamic>.from(map),
//                       ref,
//                       id,
//                       coll,
//                       firestore,
//                       isUpdate,
//                     ),
//                   ]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildAddWidget(
//       SplayTreeMap map,
//       WidgetRef ref,
//       String id,
//       CollectionReference<Map<String, dynamic>> coll,
//       QuerySnapshot<Map<String, dynamic>>? firestore,
//       bool isUpdate) {
//     TextEditingController textEditingController =
//         ref.read(textEditingControllerProvider.state).state;
//     Map<String, dynamic> trMap = {};

//     final format = new DateFormat('yyyy-MM-dd');

//     final ImagePicker _picker = ImagePicker();
//     HtmlEditorController controller = HtmlEditorController();
//     var editMap = ref.read(mapProvider);
//     if (editMap['date'] != null) {
//       textEditingController.text = editMap['date'];
//     }
//     final _formKey = GlobalKey<FormState>();
//     // final Map tempMap = {};
//     List<Widget> lw = [];
//     for (var ente in map.entries) {
//       var item = ente.key;
//       if (ente.value.toString() == 'true' || ente.value.toString() == 'false') {
//         lw.add(Consumer(
//           builder: (context, ref, child) {
//             bool? feat = ref.watch(featureProvider);
//             editMap.addAll({item: feat});
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text(item),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Checkbox(
//                     value: feat,
//                     onChanged: (value) {
//                       editMap.addAll({item: value.toString()});
//                       ref.read(featureProvider.state).state = value;
//                     },
//                   ),
//                 ],
//               ),
//             );
//           },
//         ));
//       } else if (item.toString() == 'image' || item.toString() == 'icon') {
//         lw.add(Consumer(
//           builder: (context, ref, child) {
//             var image = ref.watch(imageProvider);

//             return image == null
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(item),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       FormField(
//                         validator: (value) {
//                           if (editMap['image'] == null ||
//                               editMap['icon'] == null) {
//                             return 'this field is requird';
//                           }
//                           return null;
//                         },
//                         builder: (field) {
//                           if (field.hasError) {
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   height: 40,
//                                   width: MediaQuery.of(context).size.width / 2 -
//                                       16,
//                                   child: ElevatedButton.icon(
//                                     onPressed: () async {
//                                       var i = await _picker.pickImage(
//                                           source: ImageSource.gallery);

//                                       if (i != null) {
//                                         var p = FirebaseStorage.instance.ref(
//                                             'images/${ref.read(selectedItemProvider)}/${i.name}');

//                                         var upload = await p.putData(
//                                           await i.readAsBytes(),
//                                           SettableMetadata(
//                                               contentType: 'image/png'),
//                                         );
//                                         var durl =
//                                             await upload.ref.getDownloadURL();
//                                         ref.read(imageProvider.state).state = durl;
//                                         var x = ref.read(mapProvider);
//                                         x.addAll({item: durl});
//                                       }
//                                     },
//                                     icon: Icon(Icons.image),
//                                     label: Text('Upload Image'),
//                                     style: ElevatedButton.styleFrom(),
//                                   ),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Text(
//                                   field.errorText ?? '',
//                                   style: TextStyle(color: Colors.red),
//                                 ),
//                               ],
//                             );
//                           }
//                           return Container(
//                             height: 40,
//                             width: MediaQuery.of(context).size.width / 2 - 16,
//                             child: ElevatedButton.icon(
//                               onPressed: () async {
//                                 var i = await _picker.pickImage(
//                                     source: ImageSource.gallery);

//                                 if (i != null) {
//                                   var p = FirebaseStorage.instance.ref(
//                                       'images/${ref.read(selectedItemProvider)}/${i.name}');

//                                   var upload = await p.putData(
//                                     await i.readAsBytes(),
//                                     SettableMetadata(contentType: 'image/png'),
//                                   );
//                                   var durl = await upload.ref.getDownloadURL();
//                                   ref.read(imageProvider.state).state = durl;
//                                   var x = ref.read(mapProvider);
//                                   x.addAll({item: durl});
//                                 }
//                               },
//                               icon: Icon(Icons.image),
//                               label: Text('Upload Image'),
//                               style: ElevatedButton.styleFrom(),
//                             ),
//                           );
//                         },
//                       )
//                     ],
//                   )
//                 : SizedBox(
//                     child: Stack(
//                       children: [
//                         Image.network(
//                             ref.read(imageProvider) ?? item.value),
//                         Positioned(
//                             // top: 0,
//                             // right: 0,
//                             child: IconButton(
//                           icon: Icon(Icons.cancel_outlined),
//                           onPressed: () {
//                             FirebaseStorage.instance
//                                 .refFromURL(
//                                     ref.read(imageProvider) ?? item.value)
//                                 .delete();
//                             editMap.removeWhere((key, value) => key == item);
//                             ref.read(imageProvider.state).state = null;
//                           },
//                         ))
//                       ],
//                     ),
//                     height: 200,
//                   );
//           },
//         ));
//       } else if (item.toString() == 'html') {
//         lw.add(Consumer(
//           builder: (context, watch, child) {
//             return Column(
//               children: [
//                 SizedBox(
//                   height: 600,
//                   child: HtmlEditor(
//                     callbacks: Callbacks(
//                       onChangeContent: (val) {
//                         if (val != null && val.isNotEmpty) {
//                           ref.read(mapProvider).addAll({'html': val});
//                         }
//                       },
//                     ),
//                     controller: controller, //required
//                     htmlEditorOptions: HtmlEditorOptions(
//                       initialText: editMap[item],
//                       hint: "Your text here...",
//                       //initalText: "text content initial, if any",
//                     ),
//                     otherOptions: OtherOptions(
//                       height: 600,
//                     ),
//                     htmlToolbarOptions: HtmlToolbarOptions(
//                         toolbarType: ToolbarType.nativeGrid,
//                         defaultToolbarButtons: [
//                           StyleButtons(),
//                           FontSettingButtons(),
//                           FontButtons(),
//                           ColorButtons(),
//                           ListButtons(),
//                           ParagraphButtons(),
//                           InsertButtons(
//                               picture: false,
//                               video: false,
//                               audio: false,
//                               table: false,
//                               hr: false,
//                               otherFile: false),
//                           OtherButtons(),
//                         ]),
//                   ),
//                 ),
//                 IconButton(
//                     onPressed: () async {
//                       var i =
//                           await _picker.pickImage(source: ImageSource.gallery);

//                       if (i != null) {
//                         var p =
//                             FirebaseStorage.instance.ref('images/${i.name}');

//                         var upload = await p.putData(
//                           await i.readAsBytes(),
//                           SettableMetadata(contentType: 'image/png'),
//                         );
//                         var durl = await upload.ref.getDownloadURL();
//                         controller.insertNetworkImage(durl);
//                       }
//                     },
//                     icon: Icon(Icons.image)),
//                 // TextButton(
//                 //     onPressed: () async {
//                 //       var html = await controller.getText();
//                 //       // print(html.isEmpty ? 'empty' : html);
//                 //       // if (html.isNotEmpty) {
//                 //       //   ref.read(mapProvider).state.addAll({'html': html});
//                 //       // }
//                 //     },
//                 //     child: Text('data'))
//               ],
//             );
//           },
//         ));
//       } else if (item.toString() == 'date') {
//         lw.add(TextFormField(
//           // initialValue: editMap[item],
//           enabled: true,
//           readOnly: true,
//           controller: textEditingController,
//           // onEditingComplete: () {
//           //   ref.read(showHtmlEditorProvider).state = true;
//           // },
//           // validator: (value) {
//           //   if (value == null || value.isEmpty) {
//           //     return 'Please enter some text';
//           //   }
//           //   return null;
//           // },
//           onSaved: (newValue) {
//             editMap.addAll({item: newValue});
//           },
//           onTap: () {
//             DatePicker.showDatePicker(context, showTitleActions: true,
//                 onConfirm: (date) {
//               textEditingController.text = format.format(date);
//             }, currentTime: DateTime.now());
//           },
//           decoration: InputDecoration(
//             labelText: item,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//               borderSide: BorderSide(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ));
//       } else {
//         lw.add(Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextFormField(
//             initialValue: item == 'id'
//                 ? editMap[item] ?? ref.read(lastestIdProvider).state
//                 : item.toString().startsWith('tr_')
//                     ? translateFromFB(editMap[item].toString(), context)
//                     : editMap[item],
//             validator: (value) {
//               if (item.toString().endsWith('optional')) {
//                 return null;
//               } else if (value == null || value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               return null;
//             },
//             onSaved: (newValue) {
//               if (item.toString().startsWith('tr_')) {
//                 if (!isUpdate) {
//                   var id = Uuid().v1();

//                   var languages = ref.read(langAddressProvider).state;
//                   for (var item in languages!.docs) {
//                     var temp = item.data();

//                     temp.addAll({id: newValue});
//                     item.reference.update(temp);
//                     context.refresh(collectionProvider);
//                   }
//                   editMap.addAll({item: id});
//                 } else {
//                   // var languages = ref.read(langAddressProvider).state;
//                   // var languages = ref.read(langdocAddressProvider).state;
//                   // var temp = languages?.data();

//                   // temp!.update(editMap[item], (value) => newValue);
//                   // languages?.reference.update(temp);
//                   trMap.addAll({editMap[item]: newValue});
//                   // context.refresh(collectionProvider);
//                   // languages.docs.firstWhere((element) => element.id==)
//                 }
//               } else
//                 editMap.addAll({item: newValue});
//             },
//             decoration: InputDecoration(
//               labelText: item,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//                 borderSide: BorderSide(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ));
//       }
//     }
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width / 2,
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Add a New Item'),
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: lw,
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     // print(await controller.getText());
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       // If the form is valid, display a snackbar. In the real world,
//                       // you'd often call a server or save the information in a database.
//                       print(trMap);
//                       context
//                           .read(langdocAddressProvider)
//                           .state!
//                           .reference
//                           .update(trMap);
//                       await putData(firestore, id, context, coll, _formKey);
//                     }

//                     // t.add(tempMap);
//                   },
//                   child: Text('Save'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> putData(
//       QuerySnapshot<Map<String, dynamic>>? firestore,
//       String id,
//       BuildContext context,
//       // HtmlEditorController controller,
//       CollectionReference<Map<String, dynamic>> coll,
//       GlobalKey<FormState> _formKey) async {
//     var p = firestore!.docs.firstWhere((element) => element.id == id);
//     //map.addAll(p.data());
//     // var html = await controller.getText();
//     // print(html.isEmpty ? 'empty' : html);
//     // if (html.isNotEmpty) {
//     //   ref.read(mapProvider).state.addAll({'html': html});
//     // }
//     print(ref.read(mapProvider).state);
//     var mapProv = ref.read(mapProvider).state;
//     Map<String, dynamic> temp = p.data();
//     temp.update(temp.keys.first, (value) {
//       if (!ref.read(isUpdateProvider).state) {
//         value.add(mapProv);
//       } else {
//         value.removeWhere((element) => element['id'] == mapProv['id']);
//         value.add(mapProv);
//       }
//       return value;
//     });
//     coll.doc(id).update(temp);
//     // print(await controller.getText());
//     ref.read(isUpdateProvider).state = true;

//     context.refresh(collectionAddressProvider);
//     context.refresh(langAddressProvider);
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Succsess'),
//         backgroundColor: Colors.greenAccent,
//       ),
//     );
//     context.refresh(langProvider);
//   }
// }

// final imageProvider = StateProvider.autoDispose<String?>((ref) {
//   return null;
// });
// final featureProvider = StateProvider.autoDispose<bool?>((ref) {
//   return false;
// });

// final textEditingControllerProvider =
//     StateProvider.autoDispose<TextEditingController>((ref) {
//   return TextEditingController();
// });

// final mapProvider = StateProvider<Map>((ref) {
//   return {};
// });

// final isUpdateProvider = StateProvider.autoDispose<bool>((ref) {
//   return false;
// });
