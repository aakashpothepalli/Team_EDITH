import 'package:flutter/material.dart';
import 'package:swasth/modules/components/infocard.dart';
import 'package:swasth/modules/models.dart/packagemodel.dart';
import 'package:swasth/services/api.dart';
import 'package:swasth/services/servicelocator.dart';
import 'package:swasth/utils/textstyles.dart';
import 'package:swasth/utils/themeconfig.dart';
import 'package:dio/dio.dart';

class HistoryCard extends StatefulWidget {
  final String title;
  final String packageId;
  final bool isConfirmed;
  final bool isComplete;

  const HistoryCard(
      {Key key, this.title, this.packageId, this.isConfirmed, this.isComplete})
      : super(key: key);

  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: EdgeInsets.all(10),
        height: 140,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: !widget.isComplete
                ? (widget.isConfirmed ? Palette.lightergreen : Palette.gray)
                : Palette.darkblue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: titleTextStyle,
            ),
            Text(
              "Package ID: $widget.packageId",
              style: lightTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
            widget.isComplete
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Palette.yellow),
                    height: 30,
                    width: 100,
                    child: Text(
                      'Rate',
                      style: regularTextStyle.copyWith(fontSize: 9),
                    ),
                  )
                : Text(
                    widget.isConfirmed
                        ? "Status: Confirmed!"
                        : "Status: Awaiting doctor's approval...",
                    style: lightTextStyle,
                  ),
          ],
        ),
      ),
    );
  }
}
