import 'package:flutter/material.dart';
import 'package:swasth/app.dart';
import 'package:swasth/modules/tourist/yourpackages.dart';

const HOME_PAGE = '/home';
const YOUR_PACKAGES = '/yourpackages';

class RouterWidget {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      //uncomment and import screens as they are created
      // case '/':
      // return CustomRoute(page: Root());
      case HOME_PAGE:
        return CustomRoute(page: App());

      case YOUR_PACKAGES:
        return CustomRoute(page: YourPackages());

      default:
        print("Page doesn't exist");
    }
  }
}

class CustomRoute extends PageRouteBuilder {
  final Widget page;

  CustomRoute({
    @required this.page,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionDuration: Duration(milliseconds: 250),
          reverseTransitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
