import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'package:swasth/utils/textstyles.dart';
import 'package:url_launcher/url_launcher.dart';

class Spinner extends StatefulWidget {
  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: animController,
      curve: Curves.ease,
      //reverseCurve: Curves.elasticOut,
    );

    animation =
        Tween<double>(begin: 0, end: 2 * math.pi).animate(curvedAnimation)
          ..addListener(() {
            setState(() {});
          });

    animController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    String img = 'assets/logo-light.png';

    return Container(
        height: 200,
        width: 200,
        child: Container(
          child: Transform.rotate(
            angle: animation.value,
            child: Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                              padding: EdgeInsets.all(8),
                              height: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "You've found an easter egg!",
                                    style: titleTextStyle,
                                  ),
                                  Text(
                                    "Did you know that 'swasth' in Sanskrit stands for well-being? Oh, and our logo's triangular design is inspired by the 3 entities it connects",
                                    style: regularTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      String url =
                                          'https://www.theraleighregister.com/deathly-hallows.html';
                                      if (await canLaunch(url)) {
                                        await launch(
                                          url,
                                          forceSafariVC: false,
                                          forceWebView: false,
                                          headers: <String, String>{
                                            'my_header_key': 'my_header_value'
                                          },
                                        );
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/easter.png',
                                      height: 50,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Want some fun? Tap this egg!",
                                    style: lightTextStyle,
                                  )
                                ],
                              )),
                        );
                      });
                },
                child: Opacity(
                  opacity: 0.4,
                  child: Image.asset(
                    img,
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}
