import 'package:flutter/material.dart';
import 'package:swasth/modules/components/navigationbar.dart';
import 'package:swasth/modules/screens/shop.dart';
import 'package:swasth/modules/screens/yourpackages.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 1);
    super.initState();
  }

  void _selectTab(int _index) {
    setState(() {
      _tabController.index = _index;
    });
    print(_tabController.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Palette.AppBarBackground,
      //   title: Text('Swasth'),
      //   elevation: 5.0,
      //   actions: [
      //     IconButton(
      //         onPressed: () => Navigator.pushNamed(context, ),
      //         icon: Icon(Icons.info)),
      //     IconButton(
      //       icon: Icon(Icons.person_rounded),
      //       onPressed: () => Navigator.pushNamed(context, PROFILE_PAGE),
      //     ),
      //   ],
      // ),
      body: _buildBody(),
      bottomNavigationBar:
          NavigationBar(onTap: _selectTab, currentIndex: _tabController.index),
    );
  }

  Widget _buildBody() {
    return TabBarView(
      controller: _tabController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        YourPackages(),
        Shop(),
      ],
    );
  }
}
