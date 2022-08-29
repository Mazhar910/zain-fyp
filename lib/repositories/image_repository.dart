import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class HttpService {
  final String posURL = "http://54.92.221.39/getPosOut/";
  final String imageURL = "http://54.92.221.39/getImageOut/";

  // Future makePostRequest(Uint8List data) async {
  //   // var headers = {
  //   //   //YOUR HEADERS
  //   // };
  //   var request = http.MultipartRequest('POST', Uri.parse(posURL));
  //   //request.headers.addAll(headers);
  //   //Uint8List data = await data.readAsBytes();
  //   //List<int> list = data.cast();
  //   request.files.add(http.MultipartFile.fromBytes('file', data));

  //   // Now we can make this call

  //   var response = await request.send();
  //   //We've made a post request...
  //   //Let's read response now

  //   response.stream.bytesToString().asStream().listen((event) {
  //     var parsedJson = json.decode(event);
  //     print(parsedJson);
  //     print(response.statusCode);
  //     //It's done...
  //   });
  // }

  Future<dynamic> jsonPrediction(Uint8List _image) async {
    var map = new Map<String, dynamic>();
    map['img_str'] = _image;
    dynamic encoded = jsonEncode(map);
    // print(encoded);

    Response res = await post(Uri.parse(posURL),
        body: encoded, headers: {'content-type': 'application/json'});
    // print("${res.statusCode}this is outside if of pos");
    if (res.statusCode == 200) {
      // print("${res.statusCode}this is inside if of pos");
      dynamic body = jsonDecode(res.body);

      print(body);
      return body;
    } else {
      print("a${res.statusCode}else position ");
      throw "Unable to retrieve posts.";
    }
  }

  Future<String> imagePrediction(Uint8List _image) async {
    var map = new Map<String, dynamic>();
    map['img_str'] = _image;
    dynamic encoded = jsonEncode(map);
    //print(encoded);

    Response res = await post(Uri.parse(imageURL),
        body: encoded, headers: {'content-type': 'application/json'});
    print("${res.statusCode}this is outside if of pos");
    if (res.statusCode == 200) {
      print("${res.statusCode}this is inside if of pos");
      String _base64 = base64Encode(res.bodyBytes);
      //print(_base64);
      return _base64;
    } else {
      print("a${res.statusCode}else position ");
      throw "Unable to retrieve posts.";
    }
  }

  // Future getPostsImage(Uint8List _image) async {
  //   var map = new Map<String, dynamic>();
  //   map['img_str'] = _image;
  //   dynamic encoded = jsonEncode(map);

  //   Response res = await post(Uri.parse(imageURL),
  //       body: encoded, headers: {'content-type': 'application/json'});

  //   print("${res.statusCode}this is outside if of image");
  //   if (res.statusCode == 200) {
  //     print("${res.statusCode}this is inside if of image");
  //     dynamic body = jsonDecode(res.body);
  //     print(body);
  //     //List posts = body.toList();
  //     //print(posts);

  //     // return posts;
  //   } else {
  //     print("${res.statusCode}else image");
  //     throw "Unable to retrieve posts.";
  //   }
  // }
}
