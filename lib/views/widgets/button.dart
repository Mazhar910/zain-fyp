import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onclick;
  final IconData icon;
  const CustomButton({Key key, this.onclick, this.title, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: 'picker',
      elevation: 0,
      backgroundColor: Colors.tealAccent[400],
      hoverElevation: 0,
      label: Row(
        children: <Widget>[Icon(icon), SizedBox(width: 10), Text(title)],
      ),
      onPressed: onclick,
    );
  }
}
