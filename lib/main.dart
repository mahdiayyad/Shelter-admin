import 'package:admin/constants.dart';
import 'package:admin/controllers/UserManager.dart';
import 'package:admin/screens/providers/lang_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:admin/router/AppRouter.gr.dart';

import 'controllers/Application.dart';

Future<void> main() async {
  await UserManager().initState();
  Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var lang = ref.watch(langProvider);
    var _ = ref.watch(collectionProvider);
    // var i = riv.ref.watch(otherCollectionProvider);

    return Consumer(
      builder: (context, ref, child) {
        final AppRouter appRouter = ref.watch(appRouterProvider);
        application.appRouter = appRouter;

        return MaterialApp.router(
          routeInformationParser: appRouter.defaultRouteParser(),

          routerDelegate: appRouter.delegate(
            navigatorObservers: () {
              final List<NavigatorObserver> obs = [];
              obs.addAll(AutoRouterDelegate.defaultNavigatorObserversBuilder());
              // obs.add(FirebaseAnalyticsObserver(
              //     analytics: AnalyticsHelper.analytics));
              return obs;
            },
          ),
          debugShowCheckedModeBanner: false,
          // initialRoute: '/',
          // getPages: [
          //   GetPage(name: '/', page: () => MainScreen()),
          //   GetPage(name: '/edit', page: () => EditScreen(),transition: Transition.zoom ),
          //   // GetPage(
          //   //   name: '/third',
          //   //   page: () => Third(),
          //   //   transition: Transition.zoom
          //   // ),
          // ],
          title: 'Flutter Admin Panel',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: bgColor,
            textTheme: lang.toLanguageTag() == 'en'
                ? GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                    .apply(bodyColor: Colors.white)
                : GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme)
                    .apply(bodyColor: Colors.white),
            canvasColor: secondaryColor,
          ),
          // home: MainScreen(),
        );
      },
    );
  }
}
