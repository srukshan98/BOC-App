import 'package:boc_app/view/login.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'customContainer.dart';

class AppLoader extends StatefulWidget {
  @override
  _AppLoaderState createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _doAnimation() async {
    try{
      await _controller.forward().then((v){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
      });
      await _controller.reverse();
    } catch(e){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    _doAnimation();
    return Scaffold(
        body:LoadingAnimation(controller: _controller)
    );
  }
}

class LoadingAnimation extends StatelessWidget {
  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> scale;

  LoadingAnimation({Key key, this.controller}):
        opacity = Tween<double>(
            begin: 0.0,
            end: 1.0
        ).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.0, 0.6))
        ),
        scale = Tween<double>(
            begin: 20,
            end: 120
        ).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.0, 0.5))
        ),super(key: key);

  Widget buildAnimation(BuildContext context, Widget child) {

    return CustomContainer(
      child: Align(
        child:Opacity(
          opacity: opacity.value,
          child: Image.asset("assets/image/logo-cropped.png", width: scale.value,),
        ),
        alignment: Alignment.center,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: buildAnimation,
      animation: controller,
    );
  }
}
