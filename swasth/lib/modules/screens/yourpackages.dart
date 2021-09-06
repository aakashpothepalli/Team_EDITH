import 'package:flutter/material.dart';
import 'package:swasth/utils/textstyles.dart';
import 'package:swasth/utils/themeconfig.dart';

class YourPackages extends StatefulWidget {
  const YourPackages({Key key}) : super(key: key);

  @override
  _YourPackagesState createState() => _YourPackagesState();
}

class _YourPackagesState extends State<YourPackages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.lightgray,
      child: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Palette.darkgreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Past activities",
                  style: titleTextStyle.copyWith(color: Palette.lightgray),
                )
              ],
            ),
          )),
          Expanded(
              child: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chosen packages",
                  style: titleTextStyle,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
