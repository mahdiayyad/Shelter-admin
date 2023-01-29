import 'package:admin/router/auth_guard.dart';
import 'package:admin/screens/LoginScreen.dart';
import 'package:admin/screens/SplashScreen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:auto_route/annotations.dart';

//cmd  flutter packages pub run build_runner build --delete-conflicting-outputs

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    // AutoRoute(page: AddItemScreen, guards: [AuthGuard]),
    AutoRoute(page: MainScreen, guards: [AuthGuard]),
    AutoRoute(page: LoginScreen),
    // AutoRoute(page: EditScreen, guards: [AuthGuard]),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class $AppRouter {}
