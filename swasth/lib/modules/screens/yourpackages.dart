import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swasth/modules/components/historycard.dart';
import 'package:swasth/services/api.dart';
import 'package:swasth/services/servicelocator.dart';
import 'package:swasth/utils/enums.dart';
import 'package:swasth/utils/errortext.dart';
import 'package:swasth/utils/textstyles.dart';
import 'package:swasth/utils/themeconfig.dart';
import 'package:dio/dio.dart';

class YourPackages extends StatefulWidget {
  const YourPackages({Key key}) : super(key: key);

  @override
  _YourPackagesState createState() => _YourPackagesState();
}

class _YourPackagesState extends State<YourPackages> {
  Future<dynamic> _future;

  void _init() {
    _future = getHistory();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<dynamic> getHistory() async {
    Response<dynamic> response;
    try {
      response = await ServiceLocator<Api>().GET(Api.getHistory);
      if (response == null) {
        print('null response!');
        return Future<ErrorCategory>.error(ErrorCategory.connectionFailed);
      }
      if (response.statusCode == 200) {
        print('Response received in history:' + response.toString());
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
    double height = MediaQuery.of(context).size.height;

    return Container(
      color: Palette.lightgray,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
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
                  "Upcoming activities",
                  style: titleTextStyle.copyWith(color: Palette.lightgray),
                ),
                SizedBox(
                  height: 8,
                ),
                FutureBuilder<dynamic>(
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
                          List<Map<String, dynamic>> upcominglist = [];

                          for (int i = 0;
                              i < parsedJson['bookings'].length;
                              i++) {
                            if (parsedJson['bookings'][i]['completed'] ==
                                false) {
                              upcominglist.add(parsedJson['bookings'][i]);
                            }
                          }

                          print(upcominglist);

                          return Container(
                            height: height * 0.32,
                            child: upcominglist.isEmpty
                                ? Text(
                                    "Once you choose an activity package, you can view it's status here",
                                    style: lightTextStyle.copyWith(
                                        color: Palette.gray),
                                    textAlign: TextAlign.center,
                                  )
                                : ListView.builder(
                                    itemCount: upcominglist.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return HistoryCard(
                                        isComplete: false,
                                        isConfirmed: upcominglist[index]
                                            ['confirmed'],
                                        title: upcominglist[index]['package']
                                            ['packageTitle'],
                                        packageId: upcominglist[index]
                                            ['packageId'],
                                      );
                                    }),
                          );
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Palette.gray,
                          ),
                        );
                      }
                    }),
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
                  "Completed activities",
                  style: titleTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                FutureBuilder<dynamic>(
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

                          List<Map<String, dynamic>> completelist = [];

                          for (Map<String, dynamic> obj
                              in parsedJson['bookings']) {
                            if (obj['completed'] == true) {
                              completelist.add(obj);
                            }
                          }

                          return Container(
                            height: 200,
                            child: completelist.isEmpty
                                ? Text(
                                    'Once you finish activities, you will see them here, and can rate them',
                                    style: lightTextStyle.copyWith(
                                        color: Palette.darkblue),
                                    textAlign: TextAlign.center,
                                  )
                                : ListView.builder(
                                    itemCount: completelist.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return HistoryCard(
                                        isComplete: true,
                                        isConfirmed: completelist[index]
                                            ['confirmed'],
                                        title: completelist[index]['package']
                                            ['packageTitle'],
                                        packageId: completelist[index]
                                            ['packageId'],
                                      );
                                    }),
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
              ],
            ),
          ))
        ],
      ),
    );
  }
}
