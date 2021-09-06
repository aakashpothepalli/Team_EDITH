import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swasth/modules/components/packagecard.dart';
import 'package:swasth/modules/components/spinner.dart';
import 'package:swasth/modules/models.dart/packagemodel.dart';
import 'package:swasth/services/api.dart';
import 'package:swasth/services/servicelocator.dart';
import 'package:swasth/utils/enums.dart';
import 'package:swasth/utils/errortext.dart';
import 'package:swasth/utils/textstyles.dart';
import 'package:swasth/utils/themeconfig.dart';
import 'package:dio/dio.dart';

class Shop extends StatefulWidget {
  const Shop({Key key}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  Future<dynamic> _future;

  void _init() {
    _future = getList();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<dynamic> getList() async {
    Response<dynamic> response;
    try {
      response = await ServiceLocator<Api>().GET(Api.getShopList);
      if (response == null) {
        print('null response!');
        return Future<ErrorCategory>.error(ErrorCategory.connectionFailed);
      }
      if (response.statusCode == 200) {
        return response;
      }
      if (response.statusCode == 400) {
        return Future<ErrorCategory>.error(ErrorCategory.badRequest);
      } else {
        return Future<ErrorCategory>.error(ErrorCategory.invalidServerResponse);
      }
    } catch (e) {
      return Future<ErrorCategory>.error(ErrorCategory.invalidServerResponse);
    }
  }

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
              'Hello there,\nArun',
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
                child: FutureBuilder<dynamic>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: ErrorText(
                              errorCategory: snapshot.error,
                            ),
                          );
                        } else if (!snapshot.hasData) {
                          print('null snapshot!');
                          return Center(
                            child: ErrorText(
                              errorCategory: ErrorCategory.connectionFailed,
                            ),
                          );
                        } else {
                          var parsedJson =
                              json.decode(snapshot.data.toString());

                          return Container(
                            height: height * 0.65,
                            child: RawScrollbar(
                              isAlwaysShown: false,
                              thumbColor: Palette.darkgreen,
                              radius: Radius.circular(30),
                              child: ListView.builder(
                                itemCount: parsedJson['list'].length,
                                itemBuilder: (context, index) {
                                  return PackageCard(
                                    package: new Package(
                                        category: parsedJson['list'][index]
                                            ['category'],
                                        contactName: parsedJson['list'][index]
                                            ['contactDetails']['name'],
                                        contactNumber: parsedJson['list'][index]
                                            ['contactDetails']['number'],
                                        contactEmail: parsedJson['list'][index]
                                            ['contactDetails']['email'],
                                        description: parsedJson['list'][index]
                                            ['description'],
                                        packageId: parsedJson['list'][index]
                                            ['packageId'],
                                        packageTitle: parsedJson['list'][index]
                                            ['packageTitle'],
                                        price: parsedJson['list'][index]
                                            ['price'],
                                        rating: parsedJson['list'][index]['rating'],
                                        travelAgencyId: parsedJson['list'][index]['travelAgencyId'],
                                        duration: parsedJson['list'][index]['duration']),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Palette.darkgreen,
                          ),
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
