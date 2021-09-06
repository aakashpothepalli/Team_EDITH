import 'package:flutter/material.dart';
import 'package:swasth/modules/components/packagecard.dart';
import 'package:swasth/modules/components/spinner.dart';
import 'package:swasth/utils/textstyles.dart';
import 'package:swasth/utils/themeconfig.dart';

class Shop extends StatefulWidget {
  const Shop({Key key}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(10),
      color: Palette.lightgray,
      child: Stack(children: [
        Align(alignment: Alignment(1.2, -1.2), child: Spinner()),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello there,\nAakash',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              'We have some fun (and safe) things for you to do!',
              style: regularTextStyle,
            ),
            SingleChildScrollView(
              child: Container(
                width: width,
                height: height * 0.65,
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return PackageCard();
                    }),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
