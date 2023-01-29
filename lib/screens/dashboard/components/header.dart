// import 'package:admin/controllers/MenuController.dart';
// import 'package:admin/responsive.dart';
// import 'package:admin/screens/providers/lang_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../../constants.dart';

// class Header extends StatelessWidget {
//   final String tilte;
//   final bool withDrawer;
//   final Function(String)? onLangChange;
//   const Header({
//     Key? key,
//     required this.tilte,
//     required this.withDrawer,
//     this.onLangChange,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         if (!Responsive.isDesktop(context) && withDrawer)
//           IconButton(
//             icon: Icon(Icons.menu),
//             onPressed: () {
//               ref.read(menuStateProvider.notifier).controlMenu();
//             },
//           ),
//         if (!Responsive.isMobile(context))
//           Text(
//             tilte,
//             style: Theme.of(context).textTheme.headline6,
//           ),
//         if (!Responsive.isMobile(context))
//           Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
//         Expanded(child: SearchField()),
//         ProfileCard(onLangChange: onLangChange)
//       ],
//     );
//   }
// }

// class ProfileCard extends ConsumerWidget {
//   final Function(String)? onLangChange;

//   const ProfileCard({
//     this.onLangChange,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var lang = ref.watch(langProvider).state;
//     return PopupMenuButton(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15.0))),
//       onSelected: (value) {
//         ref.read(langProvider).state = Locale(value.toString());
//         if (onLangChange != null) {
//           onLangChange!(value.toString());
//         }
//       },
//       offset: Offset(0, 50),
//       itemBuilder: (context) {
//         return [
//           PopupMenuItem(
//             child: Text("EN"),
//             value: 'en',
//           ),
//           PopupMenuItem(
//             child: Text("AR"),
//             value: 'ar',
//           )
//         ];
//       },
//       child: Container(
//         margin: EdgeInsets.only(left: defaultPadding),
//         padding: EdgeInsets.symmetric(
//           horizontal: defaultPadding,
//           vertical: defaultPadding / 2,
//         ),
//         decoration: BoxDecoration(
//           color: secondaryColor,
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//           border: Border.all(color: Colors.white10),
//         ),
//         child: Row(
//           children: [
//             Image.asset(
//               "assets/images/${lang.toLanguageTag()}.png",
//               color: Colors.white,
//               height: 38,
//             ),
//             if (!Responsive.isMobile(context))
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
//                 child:
//                     Text(lang.toLanguageTag() == 'en' ? "English" : "Arabic"),
//               ),
//             Icon(Icons.keyboard_arrow_down),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SearchField extends StatelessWidget {
//   const SearchField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         hintText: "Search",
//         fillColor: secondaryColor,
//         filled: true,
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//         ),
//         suffixIcon: InkWell(
//           onTap: () {},
//           child: Container(
//             padding: EdgeInsets.all(defaultPadding * 0.75),
//             margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
//             decoration: BoxDecoration(
//               color: primaryColor,
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//             ),
//             child: SvgPicture.asset("assets/icons/Search.svg"),
//           ),
//         ),
//       ),
//     );
//   }
// }
