import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  var predictedimage;
  ThirdScreen({Key key, this.predictedimage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/image.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Image.memory(
                predictedimage,
                fit: BoxFit.fill,
                height: 500,
                width: 400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
