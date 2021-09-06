import 'package:flutter/material.dart';
import 'package:swasth/modules/components/infocard.dart';
import 'package:swasth/utils/textstyles.dart';
import 'package:swasth/utils/themeconfig.dart';

class PackageCard extends StatefulWidget {
  const PackageCard({Key key}) : super(key: key);

  @override
  _PackageCardState createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Palette.lightergreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Essential City Drive-Through',
            style: titleTextStyle.copyWith(color: Palette.darkblue),
          ),
          Text(
            'Manjunath Travels',
            style: lightTextStyle.copyWith(color: Palette.gray),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InfoCard(
                isPrice: false,
                value: '2 hrs',
              ),
              InfoCard(
                isPrice: true,
                value: '₹2999',
              )
            ],
          )
        ],
      ),
    );
  }
}
