import 'dart:async';

import 'package:flutter/material.dart';

class BuildYourCustomizedWidget extends StatefulWidget {
  Color color;
  BuildYourCustomizedWidget({required this.color});
  @override
  State<BuildYourCustomizedWidget> createState() => _BuildYourCustomizedWidgetState();
}

class _BuildYourCustomizedWidgetState extends State<BuildYourCustomizedWidget> {
  Timer? _timer;
  double _height=10;
  double _width=100;
  double _opacity=0;
  
  @override
  Widget build(BuildContext context) {

    String colorName=widget.color==Colors.red?"Red":"Green";

    return DefaultTextStyle(
      style: TextStyle(color: widget.color,fontSize: 26,fontWeight: FontWeight.bold),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTittle(colorName),
          _getIcon(),
          _getContainerDesign(),
        ],
      ),
    );
  }

  AnimatedContainer _getContainerDesign() {
    return AnimatedContainer(
      duration:const Duration(milliseconds: 750),
      curve: Curves.fastOutSlowIn,
      padding:const EdgeInsets.all(20),
      height: _height,
      width: _width,
      decoration: _getContainerDecoration(),
    );
  }

  AnimatedOpacity _getIcon() {
    return AnimatedOpacity(
      duration:const Duration(seconds: 1),
      opacity: _opacity,
      child: Padding(
        padding: const EdgeInsets.only(left:20),
        child: Icon(
          Icons.arrow_downward,
          color: widget.color,
          size: 60,
        ),
      ),
    );
  }

  AnimatedOpacity _getTittle(String colorName) {
    return AnimatedOpacity(
      duration:const Duration(seconds: 1),
      opacity: _opacity,
      child: Text(
        "$colorName FAB",  
      ),
    );
  }

  @override
  void initState() {
    _timer= Timer.periodic(
      const Duration(milliseconds: 100), 
      (timer) {
        if(timer.tick==1){
          _height=100;
          setState(() {});
        }
        if(timer.tick==5){
          _timer!.cancel();
          _opacity=1;
          setState(() {});
        } 
      }
      );
    super.initState();
  }

  
  BoxDecoration _getContainerDecoration() {
    return  BoxDecoration(
      border: Border.all(color: widget.color.withOpacity(1),width: 6),
      borderRadius: BorderRadius.circular(20),
    );
  }

 
  
  
}