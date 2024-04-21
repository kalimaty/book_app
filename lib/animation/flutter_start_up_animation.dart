import 'package:flutter/material.dart';

class StartUpAnimation extends StatefulWidget {
  final int crossAxisCount;
  final List<Widget> children;
  final int animationDuration;
  const StartUpAnimation(
      {Key? key,
      required this.crossAxisCount,
      required this.children,
      required this.animationDuration})
      : super(key: key);

  @override
  State<StartUpAnimation> createState() => _StartUpAnimationState();
}

class _StartUpAnimationState extends State<StartUpAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  List<Animation<double>> animations = [];
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: widget.animationDuration,
      ),
    );
    double wait = 1 / widget.children.length;
    double start = 0.0;
    double end = wait;
    for (int i = 0; i < widget.children.length; i++) {
      Animation<double> animation = CurveTween(
        curve: Interval(
          start,
          end,
          curve: Curves.linear,
        ),
      ).animate(animationController);
      animations.add(animation);
      start += wait;
      end += wait;
    }
    animationController.forward();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GridView.count(
        padding: EdgeInsets.all(16),
        scrollDirection: Axis.vertical,
        // physics: AlwaysScrollableScrollPhysics(),
        crossAxisCount: widget.crossAxisCount,
        children: widget.children.map((child) {
          int index = widget.children.indexWhere(
            (element) => element == child,
          );
          return ScaleTransition(
            // alignment: Alignment.centerRight,
            scale: animations[index],
            child: child,
          );
        }).toList(),
      ),
    );
  }
}
