import 'dart:ui';

import 'package:admin/controllers/Application.dart';
import 'package:admin/router/AppRouter.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Session.dart';

class UserManager {
  SharedPreferences? prefs;

  Future<UserManager> initState() async {
    prefs = await SharedPreferences.getInstance();
    // Session.mToken = await getToken();
    Session.isLogedIn = await isLogedIn();
    return this;
  }

  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;
  UserManager._internal() {
    initState();
  }

  Future<bool> isLogedIn() async {
    final bool logedin = await getBool('isLogedIn');
    Session.isLogedIn = logedin;
    return logedin;
  }

  // ignore: avoid_positional_boolean_parameters
  void setisLogedIn(bool b) {
    Session.isLogedIn = b;
    setBool('isLogedIn', b);
  }

  Future<String> getToken() async {
    return Session.mToken = await getString('Token');
  }

  void setToken(String? token) {
    Session.mToken = token;
    setString('Token', token);
  }

  // Future<String> getAppLang() async {
  //   var lang = await getString('AppLang');

  //   if (lang == null) {
  //     final _sysLng = ui.window.locale.languageCode;
  //     print("SysLang = $_sysLng");
  //     final isSupported = application.supportedLanguagesCodes.contains(_sysLng);
  //     if (isSupported) {
  //       lang = _sysLng;
  //     } else {
  //       lang = "en";
  //     }
  //   }

  //   Session.appLang = Locale('ar');
  //   return lang;
  // }

  void setAppLang(String lang) {
    Session.appLang = Locale(lang);
    setString('AppLang', lang);
  }

  // ignore: avoid_positional_boolean_parameters
  void setBool(String key, bool value) {
    if (prefs != null) {
      prefs!.setBool(key, value);
    } else {
      SharedPreferences.getInstance().then((SharedPreferences prefs) {
        this.prefs = prefs;
        prefs.setBool(key, value);
      });
    }
  }

  Future<bool> getBool(String key, {bool defult = false}) async {
    if (prefs != null) {
      return prefs!.getBool(key) ?? defult;
    }
    prefs = await SharedPreferences.getInstance();
    return prefs?.getBool(key) ?? defult;
  }

  void setString(String key, String? value) {
    if (prefs != null) {
      prefs?.setString(key, value ?? '');
    } else {
      SharedPreferences.getInstance().then((SharedPreferences prefs) {
        this.prefs = prefs;
        prefs.setString(key, value ?? "");
      });
    }
  }

  Future<String> getString(String key) async {
    if (prefs != null) {
      return prefs!.getString(key)!;
    }
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(key)!;
  }

  void setDouble(String key, double value) {
    if (prefs != null) {
      prefs?.setDouble(key, value);
    } else {
      SharedPreferences.getInstance().then((SharedPreferences prefs) {
        this.prefs = prefs;
        prefs.setDouble(key, value);
      });
    }
  }

  Future<double> getDouble(String key) async {
    if (prefs != null) {
      return prefs!.getDouble(key)!;
    }
    prefs = await SharedPreferences.getInstance();
    return prefs!.getDouble(key)!;
  }

  void setInt(String key, int value) {
    if (prefs != null) {
      prefs!.setInt(key, value);
    } else {
      SharedPreferences.getInstance().then((SharedPreferences prefs) {
        this.prefs = prefs;
        prefs.setInt(key, value);
      });
    }
  }

  Future<int> getInt(String key) async {
    if (prefs != null) {
      return prefs!.getInt(key)!;
    }
    prefs = await SharedPreferences.getInstance();
    return prefs!.getInt(key)!;
  }

  void logout() {
    clear();
    postDelayed(callbak: () {
      application.replace(SplashRoute());
    });
  }

  void notAuth() {
    clear();
    application.appRouter!.root.popUntil((route) => route.isFirst);
    application.navigateReplace(LoginRoute(onLoginResult: (bool) {}));
  }

  void clear() {
    // setToken(null);
    setisLogedIn(false);
  }
}
