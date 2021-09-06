import 'package:flutter/material.dart';
import 'package:swasth/modules/components/infocard.dart';
import 'package:swasth/modules/models.dart/packagemodel.dart';
import 'package:swasth/utils/textstyles.dart';
import 'package:swasth/utils/themeconfig.dart';

class PackageCard extends StatefulWidget {
  final Package package;

  const PackageCard({Key key, this.package}) : super(key: key);

  @override
  _PackageCardState createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  void showDetails(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: Palette.darkgreen),
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.package.packageTitle,
                    style: titleTextStyle.copyWith(color: Palette.lightgray),
                  ),
                  Text(
                    widget.package.contactName,
                    style: titleTextStyle.copyWith(color: Palette.gray),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Palette.lightergreen),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.package.description),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InfoCard(
                              isPrice: false,
                              value: widget.package.duration,
                            ),
                            InfoCard(
                              isPrice: true,
                              value: widget.package.price.toString(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Palette.yellow),
                      height: 50,
                      width: 175,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Proceed'),
                          Text(
                            'This will ask your doctor for approval',
                            style: lightTextStyle.copyWith(fontSize: 9),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDetails(context);
      },
      child: Container(
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
              widget.package.packageTitle,
              style: titleTextStyle.copyWith(color: Palette.darkblue),
            ),
            Text(
              widget.package.contactName,
              style: lightTextStyle.copyWith(color: Palette.gray),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(
                  isPrice: false,
                  value: widget.package.duration,
                ),
                InfoCard(
                  isPrice: true,
                  value: widget.package.price.toString(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
