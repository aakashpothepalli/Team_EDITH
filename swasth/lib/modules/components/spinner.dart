import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

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
    String img = 'logo-light.png';

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
                          child: Text("You've found an easter egg!"),
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
