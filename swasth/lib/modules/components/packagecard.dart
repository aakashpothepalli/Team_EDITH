import 'package:flutter/material.dart';
import 'package:swasth/modules/components/infocard.dart';
import 'package:swasth/modules/models.dart/packagemodel.dart';
import 'package:swasth/services/api.dart';
import 'package:swasth/services/servicelocator.dart';
import 'package:swasth/utils/textstyles.dart';
import 'package:swasth/utils/themeconfig.dart';
import 'package:dio/dio.dart';

class PackageCard extends StatefulWidget {
  final Package package;

  const PackageCard({Key key, this.package}) : super(key: key);

  @override
  _PackageCardState createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool isLoading = false;

  void showDetails(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: Palette.darkgreen),
            height: height * 0.5,
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
                    height: height * 0.3,
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Palette.lightergreen),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.package.description),
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
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        Response<dynamic> response;
                        try {
                          response = await ServiceLocator<Api>()
                              .POST(Api.sendBooking, {
                            "patientId": '91914',
                            "packageId": widget.package.packageId,
                          });
                          print(response.statusCode);
                          if (response.statusCode == 200) {
                            print(response);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Container(
                                      height: 250,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Yay! Your choice is noted',
                                            style: titleTextStyle,
                                          ),
                                          Text(
                                            'Once your doctor approves this from his side, you can make the final payment.',
                                            style: regularTextStyle,
                                          ),
                                          Text(
                                            "You can view the status under 'My Packages'",
                                            style: regularTextStyle,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        } catch (e) {
                          print('error detected');
                          print(e);
                        }
                        print(response);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Palette.yellow),
                        height: 70,
                        width: 200,
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Column(
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
        height: 110,
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
