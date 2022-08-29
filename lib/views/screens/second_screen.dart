import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_app/repositories/image_repository.dart';
import 'package:web_app/views/screens/first_screen.dart';
import 'package:web_app/views/screens/third_screen.dart';
import 'package:web_app/views/widgets/button.dart';
import 'dart:html' as html;

class SecondScreen extends StatefulWidget {
  var bounded_image;
  var generatedCode;
  SecondScreen({Key key, this.bounded_image, this.generatedCode})
      : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FirstScreen()),
                  );
                },
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Image.memory(
                  widget.bounded_image,
                  fit: BoxFit.fill,
                  height: 500,
                  width: 400,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              icon: Icons.remove_red_eye,
              title: "See prediction",
              onclick: () async {
                String result =
                    await httpService.imagePrediction(widget.bounded_image);
                if (result != null) {
                  Uint8List bytes = base64Decode(result);
                  showDialog(
                      context: context,
                      builder: (c) => AlertDialog(
                            title: Center(
                              child: Text('Predicted Output'),
                            ), // To display the title it is optional
                            content: Image.memory(
                              bytes,
                              fit: BoxFit.fill,
                              height: 500,
                              width: 400,
                            ), // Message which will be pop up on the screen
                          ));
                }
              },
            ),
            SizedBox(
              width: 10,
            ),
            CustomButton(
              icon: Icons.file_download,
              title: "Download Dart Code",
              onclick: () {
                final text = widget.generatedCode;

                // prepare
                final bytes = utf8.encode(text);
                final blob = html.Blob([bytes]);
                final url = html.Url.createObjectUrlFromBlob(blob);
                final anchor =
                    html.document.createElement('a') as html.AnchorElement
                      ..href = url
                      ..style.display = 'none'
                      ..download = 'some_name.txt';
                html.document.body.children.add(anchor);

                // download
                if (widget.bounded_image != null) {
                  anchor.click();
                } else {
                  Fluttertoast.showToast(
                      msg: "Select image first",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                //anchor.click();

                // cleanup
                html.document.body.children.remove(anchor);
                html.Url.revokeObjectUrl(url);
              },
            )
          ],
        ),
      ),
    );
  }
}
