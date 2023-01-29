import 'package:admin/router/AppRouter.gr.dart';
import 'package:admin/router/auth_guard.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:in_app_review/in_app_review.dart';

import 'package:url_launcher/url_launcher.dart';

final appRouterProvider = Provider((ref) => AppRouter(authGuard: AuthGuard()));
// final langNotifierProvider = StateNotifierProvider<LangNotifier, Locale>(
//     (ref) => LangNotifier(Session.appLang));

// class LangNotifier extends StateNotifier<Locale> {
//   LangNotifier(Locale lang) : super(lang);

//   void setLang(Locale lang) {
//     state = lang;

//   }
// }

class Application {
  static final Application _application = Application._internal();

  factory Application() {
    return _application;
  }
  Application._internal();
  // late AppLocalizations appTranslations;

  //function to be invoked when changing the language
  // LocaleChangeCallback? onLocaleChanged;

  // List<Function(AppLocalizations)> callbaks = <Function(AppLocalizations)>[];
  // void notifyOnLocaleChanged(AppLocalizations appTranslations) {
  //   this.appTranslations = appTranslations;
  //   // Log.pr("notifyOnLocaleChanged ${appTranslations.currentLanguage}");
  //   for (final item in callbaks) {
  //     item(appTranslations);
  //   }

// Future<void> navigateRoot(BuildContext context, PageRouteInfo route,
//     {Object arguments, void Function(dynamic) onFailure}) {
//   routerOf(context).popUntil((route) => route.isFirst);

//   return routerOf(context).replace(route, onFailure: onFailure);
// }
  AppRouter? appRouter;
// StackRouter get appRouter => ProviderContainer().read(appRouterProvider);
// StackRouter routerOf(BuildContext context) {
//   return AutoRouter.of(context);
// }

  void popUntilfirst() {
    return appRouter?.popUntil((route) => route.isFirst);
  }

  void popUntil(String routeName) {
    appRouter?.popUntil((route) => route.settings.name == routeName);
  }

  void pop() {
    appRouter?.pop();
  }

  Future<Object?> navigatePush(PageRouteInfo route) {
    try {
      return appRouter!.push(route);
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      // Log.e(e);
    }
    return Future.value(null);
  }

  bool isFirst(PageRouteInfo route) {
    try {
      return appRouter!.isRouteActive(route.routeName);
    } on Exception {
      // Log.e(e);
    }
    return false;
  }

  Future<Object?> navigateReplace(PageRouteInfo route) {
    return appRouter!.popAndPush(route);
  }

  Future<Object?> replace(PageRouteInfo route) {
    return appRouter!.replace(route);
  }

  Future<Object?> navigateRoot(PageRouteInfo route) {
    appRouter!.popUntilRoot();
    return appRouter!.replace(route);
  }

// void addOnLocaleChanged(Function(AppLocalizations) l) {
//   callbaks.add(l);
// }

// void removeOnLocaleChanged(Function(AppLocalizations) l) {
//   callbaks.remove(l);
// }

// Future<void> setLang(int index, BuildContext context) async {
//   UserManager().setAppLang(AppLocalizations.supportedLanguagesCodes[index]);
//   final newLang = AppLocalizations.supportedLocales().toList()[index];
//   final appTranslations = await AppLocalizations.delegate.load(newLang);
//   Log.pr("load Done");
//   ref.read(langNotifierProvider.notifier).setLang(Session.appLang);
//   application.notifyOnLocaleChanged(appTranslations);
// }

// String translate(String key, {List<dynamic>? args}) {
//   final String str = appTranslations.translate(key);
//   if (args != null) {
//     return sprintf(str, args);
//   }
//   return str;
// }

  Future<void> launchLocation(String lat, String lng) async {
    final String googleMapsUrl = "comgooglemaps://?center=$lat,$lng";
    final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
      return;
    }
    if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl, forceSafariVC: false);
    } else {
      // Log.pr('Could not launch location');
    }
  }

  Future<bool> launchURL({required String url}) async {
    if (await canLaunch(url)) {
      final b = await launch(url);
      return b;
    } else {
      // Log.pr('Could not launch $url');
      return false;
    }
  }

  void lunchPhone({required String phoneNumber}) {
    launchURL(url: "tel:$phoneNumber");
  }

  Future<void> launchEmail({required String email}) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    final String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Log.pr('Could not launch $url');
    }
  }

// Future inAppReview() async {
//   final InAppReview inAppReview = InAppReview.instance;
//   final bool israted = await UserManager().isRated();
//   if (israted) {
//     return;
//   }
//   if (await inAppReview.isAvailable()) {
//     inAppReview.requestReview();
//     UserManager().setisRated(true);
//   }
// }
// bool isRtl() {
//   return appTranslations.currentLanguage == AppLocalizations.ar;
// }

// Future<OpenResult> openFile(String path) {
//   return OpenFile.open(path);
// }
}

Application application = Application();

typedef LocaleChangeCallback = void Function(Locale locale);

void postDelayed({int milliseconds = 100, required VoidCallback callbak}) {
  Future.delayed(Duration(milliseconds: milliseconds), () {
    callbak();
  });
}

// String translateFromFB(String? key, BuildContext context) {
//   var map = ref.read(langMapProvider).state;
//   if (key == null) return '';
//   try {
//     var str = map?.entries.firstWhere((element) => element.key == key);
//     return str!.value.toString();
//   } catch (e) {
//     return '';
//   }

//   // String str;
//   // for (var item in map!.entries) {
//   //   if (item.key == key) {
//   //     str = item.value.toString();
//   //     return str;
//   //   }
//   // }
//   // print(str);
//   // return 'not found';
// }
