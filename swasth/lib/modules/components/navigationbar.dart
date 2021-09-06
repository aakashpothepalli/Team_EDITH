import 'package:flutter/material.dart';
import 'package:swasth/utils/themeconfig.dart';

class NavigationBar extends StatelessWidget {
  final Function(int) onTap;

  final int currentIndex;

  const NavigationBar({
    Key key,
    @required this.onTap,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Palette.lightgray,
      selectedItemColor: Palette.darkblue,
      unselectedItemColor: Palette.gray,
      onTap: onTap,
      currentIndex: currentIndex,
      elevation: 5,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.history_rounded),
          label: "Your packages",
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_rounded),
          label: "Home",
        ),
      ],
    );
  }
}
