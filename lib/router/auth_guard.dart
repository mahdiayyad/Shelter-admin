import 'package:admin/controllers/Session.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'AppRouter.gr.dart';

class AuthGuard extends AutoRouteGuard {
  // @override
  // Future<bool> canNavigate(
  //     NavigationResolver resolver, StackRouter router) async {
  //   if (!Session.isLogedIn) {
  //     // ignore: unawaited_futures
  //     router.root.push(LoginRoute(
  //         showBackButton: resolver.route is! MainRoute,
  //         onLoginResult: (success) {
  //           if (success) {
  //             // router.replaceAll(pendingRoutes);
  //           }
  //         }));
  //     return false;
  //   }
  //   return true;
  // }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // var user = FirebaseAuth.instance.currentUser;
    if (Session.isLogedIn && FirebaseAuth.instance.currentUser != null) {
      resolver.next();
    } else {
      router.root.push(LoginRoute(
          showBackButton: resolver.route is! MainRoute,
          onLoginResult: (success) {
            if (success) {
              // router.replaceAll(pendingRoutes);
            }
          }));

      resolver.next(false);
    }
  }
}
