import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final bool isPrice;
  final String value;
  const InfoCard({Key key, this.isPrice, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(this.isPrice ? Icons.money_rounded : Icons.access_time_rounded),
          Text(this.value)
        ],
      ),
    );
  }
}
