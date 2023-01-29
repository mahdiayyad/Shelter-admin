// import 'package:intl/intl.dart';

// import 'package:admin/controllers/Application.dart';
// import 'package:admin/screens/AddItemScreen.dart';
// import 'package:admin/screens/dashboard/components/header.dart';
// import 'package:admin/screens/main/components/side_menu.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
// import 'package:image_picker/image_picker.dart';
// import 'providers/lang_provider.dart';

// class EditScreen extends ConsumerWidget {
//   EditScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var widget = ref.watch(widgetProvider).state;

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 100,
//         title: Header(
//           tilte: 'Edit Item',
//           withDrawer: false,
//           onLangChange: (val) {
//             // map = {'samer': 'samer'};
//             context.refresh(collectionProvider);
//           },
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(children: [widget]),
//           ),
//         ),
//       ),
//     );
//   }

//   final widgetProvider = StateProvider<Widget>((ref) {
//     final id = ref.watch(selectedItemProvider).state;
//     Map<String, dynamic> mapState = ref.watch(tableDataProvider).state;
//     // final _ = ref.watch(langProvider).state;
//     bool isSingle = mapState.keys.length > 1;
//     Map<String, dynamic> selectedMap =
//         isSingle ? mapState : ref.watch(selectedTapleCellProvider).state;
//     final coll = ref.watch(collectionAddressProvider).state;
//     final firestore = ref.watch(firestoreItemProvider).state;
//     final _formKey = GlobalKey<FormState>();
//     var context =
//         application.appRouter!.navigatorKey.currentState!.overlay!.context;
//     List<Widget> lw = [];
//     final ImagePicker _picker = ImagePicker();
//     HtmlEditorController controller = HtmlEditorController();
//     Map<String, dynamic> trMap = {};
//     TextEditingController textEditingController =
//         ref.read(textEditingControllerProvider).state;
//     final format = new DateFormat('yyyy-MM-dd');

//     // final _formKey = GlobalKey<FormState>();
//     // final Map tempMap = {};
//     // List<Widget> lw = [];
//     for (var item in selectedMap.entries) {
//       if (item.value.toString() == 'true' || item.value.toString() == 'false') {
//       } else if (item.key.toString() == 'image' ||
//           item.key.toString() == 'icon') {
//         var link = item.value;
//         lw.add(Consumer(
//           builder: (context, watch, child) {
//             var imageprov = watch(imageProvider).state;

//             return imageprov == null && link == null
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(item.key),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Container(
//                         height: 40,
//                         width: MediaQuery.of(context).size.width / 2 - 16,
//                         child: ElevatedButton.icon(
//                           onPressed: () async {
//                             var i = await _picker.pickImage(
//                                 source: ImageSource.gallery);

//                             if (i != null) {
//                               var p = FirebaseStorage.instance.ref(
//                                   'images/${ref.read(selectedItemProvider).state}/${i.name}');

//                               print(i.path);
//                               var upload = await p.putData(
//                                 await i.readAsBytes(),
//                                 SettableMetadata(contentType: 'image/png'),
//                               );
//                               var durl = await upload.ref.getDownloadURL();
//                               ref.read(imageProvider).state = durl;
//                               var x = selectedMap;
//                               x.addAll({item.key: durl});
//                               print(x);
//                             }
//                           },
//                           icon: Icon(Icons.image),
//                           label: Text('Upload Image'),
//                           style: ElevatedButton.styleFrom(),
//                         ),
//                       )
//                     ],
//                   )
//                 : SizedBox(
//                     child: Stack(
//                       children: [
//                         Image.network(imageprov ?? item.value),
//                         Positioned(
//                             // top: 0,
//                             // right: 0,
//                             child: IconButton(
//                           icon: Icon(Icons.cancel_outlined),
//                           onPressed: () async {
//                             String fileurl = imageprov ?? item.value;
//                             String filePath = fileurl.replaceAll(
//                                 new RegExp(
//                                     r'https://firebasestorage.googleapis.com/v0/b/sp-apps-website.appspot.com/o/'),
//                                 '');

//                             filePath =
//                                 filePath.replaceAll(new RegExp(r'%2F'), '/');

//                             filePath = filePath.replaceAll(
//                                 new RegExp(r'(\?alt).*'), '');

//                             Reference storageReferance =
//                                 FirebaseStorage.instance.ref();

//                             storageReferance.child(filePath).delete().then(
//                                 (_) => print(
//                                     'Successfully deleted $filePath storage item'));

//                             // var imgref =
//                             //     FirebaseStorage.instance.ref().child(filePath);

//                             // print(await imgref.getDownloadURL());
//                             link = null;

//                             // tableDataProvider
//                             ref.read(imageProvider).state = null;
//                           },
//                         ))
//                       ],
//                     ),
//                     height: 200,
//                   );
//           },
//         ));
//       } else if (item.key.toString() == 'html') {
//         lw.add(
//           Column(
//             children: [
//               SizedBox(
//                 height: 600,
//                 child: HtmlEditor(
//                   controller: controller,
//                   plugins: [],
//                   callbacks: Callbacks(
//                     onChangeContent: (val) {
//                       if (val != null && val.isNotEmpty) {
//                         selectedMap.addAll({'html': val});
//                       }
//                     },
//                   ),
//                   //required
//                   htmlEditorOptions: HtmlEditorOptions(
//                     hint: "Your text here...",
//                     initialText: item.value,

//                     //initalText: "text content initial, if any",
//                   ),
//                   otherOptions: OtherOptions(
//                     height: 550,
//                   ),
//                   htmlToolbarOptions: HtmlToolbarOptions(
//                       toolbarType: ToolbarType.nativeGrid,
//                       defaultToolbarButtons: [
//                         StyleButtons(),
//                         FontSettingButtons(fontSizeUnit: false),
//                         FontButtons(clearAll: false),
//                         ColorButtons(),
//                         ListButtons(listStyles: false),
//                         ParagraphButtons(
//                             textDirection: false,
//                             lineHeight: false,
//                             caseConverter: false),
//                         InsertButtons(
//                             picture: false,
//                             video: false,
//                             audio: false,
//                             table: false,
//                             hr: false,
//                             otherFile: false),
//                         OtherButtons(),
//                       ]),
//                 ),
//               ),
//               IconButton(
//                   onPressed: () async {
//                     var i =
//                         await _picker.pickImage(source: ImageSource.gallery);

//                     if (i != null) {
//                       var p = FirebaseStorage.instance.ref('images/${i.name}');

//                       var upload = await p.putData(
//                         await i.readAsBytes(),
//                         SettableMetadata(contentType: 'image/png'),
//                       );
//                       var durl = await upload.ref.getDownloadURL();
//                       controller.insertNetworkImage(durl);
//                     }
//                   },
//                   icon: Icon(Icons.image)),
//             ],
//           ),
//         );
//       } else if (item.key.toString() == 'date') {
//         print(item.value.toString());
//         lw.add(TextFormField(
//           controller: textEditingController,
//           enabled: true,
//           readOnly: true,
//           // onEditingComplete: () {
//           //   ref.read(showHtmlEditorProvider).state = true;
//           // },
//           // validator: (value) {
//           //   if (value == null || value.isEmpty) {
//           //     return 'Please enter some text';
//           //   }
//           //   return null;
//           // },
//           // onSaved: (newValue) {
//           //   selectedMap.addAll({item: newValue});
//           // },
//           //   initialDate: DateTime.parse(item.value.toString()),
//           onSaved: (newValue) {
//             if (newValue!.isNotEmpty) {
//               selectedMap.addAll({item.key: newValue});
//             }
//           },

//           onTap: () {
//             DatePicker.showDatePicker(
//               context,
//               showTitleActions: true,
//               onConfirm: (date) {
//                 textEditingController.text = format.format(date);
//               },
//               currentTime: DateTime.parse(item.value.toString()),
//             );
//           },
//           // helpText: item.value.toString(),
//           decoration: InputDecoration(
//             labelText: item.value.toString(),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//               borderSide: BorderSide(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ));
//         // lw.add(FormBuilderDateTimePicker(
//         //   format: DateFormat('yyyy-MM-dd'),
//         //   useRootNavigator: false,
//         //   initialDate: DateTime.parse(item.value.toString()),
//         //   helpText: item.value.toString(),
//         //   name: item.key,
//         //   validator: (value) {
//         //     if (value == null || value.isAfter(DateTime.now())) {
//         //       return 'Please enter some text';
//         //     }
//         //     return null;
//         //   },
//         //   onSaved: (newValue) {
//         //     selectedMap.addAll({item: newValue});
//         //   },
//         //   decoration: InputDecoration(
//         //     labelText: item.value,
//         //     border: OutlineInputBorder(
//         //       borderRadius: BorderRadius.circular(8.0),
//         //       borderSide: BorderSide(
//         //         color: Colors.white,
//         //       ),
//         //     ),
//         //   ),
//         // ));
//       } else {
//         String? initval = item.key.toString().startsWith('tr_')
//             ? translateFromFB(item.value.toString(), context)
//             : item.value;
//         lw.add(Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextFormField(
//             maxLines: initval != null && initval.length > 140 ? 4 : null,
//             initialValue: initval,
//             validator: (value) {
//               if (item.key.toString().endsWith('optional')) {
//                 return null;
//               } else if (value == null || value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               return null;
//             },
//             onSaved: (newValue) {
//               if (item.key.toString().startsWith('tr_')) {
//                 // var languages = ref.read(langAddressProvider).state;
//                 // var languages = ref.read(langdocAddressProvider).state;
//                 // var temp = languages?.data();
//                 // print(selectedMap[item.key]);
//                 // temp!.update(selectedMap[item.key], (value) => newValue);
//                 // print(temp);
//                 trMap.addAll({item.value: newValue});
//                 // await languages?.reference.update(temp);
//                 // context.refresh(collectionProvider);
//                 // languages.docs.firstWhere((element) => element.id==)

//               } else
//                 selectedMap.addAll({item.key: newValue});
//             },
//             decoration: InputDecoration(
//               labelText: item.key,
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

//                       var p = firestore!.docs
//                           .firstWhere((element) => element.id == id);
//                       // selectedMap.addAll(p.data());
//                       print(selectedMap);
//                       Map<String, dynamic> mapProv = selectedMap;
//                       Map<String, dynamic> temp = p.data();
//                       if (isSingle) {
//                         temp = mapProv;
//                         // print(mapProv);
//                       } else {
//                         temp.update(temp.keys.first, (value) {
//                           var index = value.indexWhere(
//                               (element) => element['id'] == mapProv['id']);
//                           value.removeAt(index);
//                           value.insert(index, mapProv);
//                           return value;
//                         });
//                       }
//                       print(trMap);
//                       await context
//                           .read(langdocAddressProvider)
//                           .state!
//                           .reference
//                           .update(trMap);
//                       await coll.doc(id).update(temp);
//                       // context.refresh(langCollectionAddressProvider);
//                       await context.refresh(collectionProvider);

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Succsess'),
//                           backgroundColor: Colors.greenAccent,
//                         ),
//                       );
//                       context.refresh(langProvider);
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
//   });
// }
