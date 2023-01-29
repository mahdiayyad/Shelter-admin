// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

// import '../screens/AddItemScreen.dart' as _i5;
// import '../screens/EditScreen.dart' as _i8;
import '../screens/LoginScreen.dart' as _i7;
import '../screens/main/main_screen.dart' as _i6;
import '../screens/SplashScreen.dart' as _i4;
import 'auth_guard.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter(
      {_i2.GlobalKey<_i2.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i3.AuthGuard authGuard;

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.SplashScreen());
    },
    // AddItemRoute.name: (routeData) {
    //   final args = routeData.argsAs<AddItemRouteArgs>();
    //   return _i1.MaterialPageX<dynamic>(
    //       routeData: routeData,
    //       child: _i5.AddItemScreen(key: args.key, map: args.map));
    // },
    MainRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.MainScreen());
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.LoginScreen(
              key: args.key,
              onLoginResult: args.onLoginResult,
              showBackButton: args.showBackButton));
    },
    // EditRoute.name: (routeData) {
    //   final args =
    //       routeData.argsAs<EditRouteArgs>(orElse: () => const EditRouteArgs());
    //   return _i1.MaterialPageX<dynamic>(
    //       routeData: routeData, child: _i8.EditScreen(key: args.key));
    // }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashRoute.name, path: '/'),
        _i1.RouteConfig(AddItemRoute.name,
            path: '/add-item-screen', guards: [authGuard]),
        _i1.RouteConfig(MainRoute.name,
            path: '/main-screen', guards: [authGuard]),
        _i1.RouteConfig(LoginRoute.name, path: '/login-screen'),
        _i1.RouteConfig(EditRoute.name,
            path: '/edit-screen', guards: [authGuard]),
        _i1.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

class SplashRoute extends _i1.PageRouteInfo<void> {
  const SplashRoute() : super(name, path: '/');

  static const String name = 'SplashRoute';
}

class AddItemRoute extends _i1.PageRouteInfo<AddItemRouteArgs> {
  AddItemRoute({_i2.Key? key, required Map<dynamic, dynamic> map})
      : super(name,
            path: '/add-item-screen',
            args: AddItemRouteArgs(key: key, map: map));

  static const String name = 'AddItemRoute';
}

class AddItemRouteArgs {
  const AddItemRouteArgs({this.key, required this.map});

  final _i2.Key? key;

  final Map<dynamic, dynamic> map;
}

class MainRoute extends _i1.PageRouteInfo<void> {
  const MainRoute() : super(name, path: '/main-screen');

  static const String name = 'MainRoute';
}

class LoginRoute extends _i1.PageRouteInfo<LoginRouteArgs> {
  LoginRoute(
      {_i2.Key? key,
      required void Function(bool)? onLoginResult,
      bool? showBackButton = false})
      : super(name,
            path: '/login-screen',
            args: LoginRouteArgs(
                key: key,
                onLoginResult: onLoginResult,
                showBackButton: showBackButton));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs(
      {this.key, required this.onLoginResult, this.showBackButton = false});

  final _i2.Key? key;

  final void Function(bool)? onLoginResult;

  final bool? showBackButton;
}

class EditRoute extends _i1.PageRouteInfo<EditRouteArgs> {
  EditRoute({_i2.Key? key})
      : super(name, path: '/edit-screen', args: EditRouteArgs(key: key));

  static const String name = 'EditRoute';
}

class EditRouteArgs {
  const EditRouteArgs({this.key});

  final _i2.Key? key;
}
