import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0), curve: null),
      Track("translateY").add(
        Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
        curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: (animation as Map)["opacity"],
        child: Transform.translate(
          offset: Offset(0, animation["translateY"]), 
          child: child
        ),
      ),
    );
  }
}

Widget ControlledAnimation({required Duration delay, required duration, required MultiTrackTween tween, required Widget child, required Opacity Function(dynamic context, dynamic child, dynamic animation) builderWithChild}) {
}

class Track {
  Track(String s);
  
  add(Duration duration, Tween<double> tween, {required Cubic curve}) {}
}

class MultiTrackTween {
  MultiTrackTween(List<dynamic> list);
  
  get duration => null;
}