import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_app/repositories/image_repository.dart';
import 'package:web_app/views/screens/help_screen.dart';
import 'package:web_app/views/screens/second_screen.dart';
import 'package:web_app/views/widgets/button.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final List<String> testImage_list = [
    'images/test/img1.jpeg',
    'images/test/img2.jpeg',
    'images/test/img3.jpeg',
    'images/test/img4.jpeg',
    'images/test/img5.jpeg',
    'images/test/img6.jpeg',
    'images/test/img7.png',
  ];

  //Uint8List imagevalue;
  bool imageAvailable = false;
  Uint8List imageFile;
  Uint8List samplefile;
  void loadAsset(String name) async {
    var data = await rootBundle.load(name);
    samplefile = data.buffer.asUint8List();
  }

  int value;

  String code;

  bool loader = false;

  //File selectedImage;
  ImagePicker imagePicker = ImagePicker();

  HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "images/image.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: width,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.ac_unit,
                      size: 40,
                      color: Colors.transparent,
                    ),
                    Spacer(),
                    Text(
                      'Image',
                      style: TextStyle(
                        fontFamily: 'Karla',
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: IconButton(
                          icon: Icon(
                            Icons.help,
                            size: 40,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HelpScreen()),
                            );
                          }),
                    )
                  ],
                ),
              ),
              imageFile != null
                  ? SizedBox(
                      height: 500,
                      width: 400,
                      child: Image.memory(
                        imageFile,
                        fit: BoxFit.fill,
                      ),
                    )
                  : CarouselSlider(
                      options: CarouselOptions(
                        height: 500,
                      ),
                      items: testImage_list.map((e) {
                        print(e);
                        return Container(
                          width: 400,
                          child: GestureDetector(
                            onTap: () {
                              loadAsset(e);
                              Fluttertoast.showToast(
                                  msg: "Sample image selected");
                            },
                            child: Center(
                                child: Image.asset(e,
                                    fit: BoxFit.fill, width: 1000)),
                          ),
                        );
                      }).toList(),
                    ),
              // itemCount: testImage_list.length,
              // itemBuilder: (context, index, realindex) {
              //   final testImage = testImage_list[index];
              //   value = index;
              //   print(testImage_list.length);
              //   print("index" + value.toString());
              //   loadAsset(testImage);
              //   return Container(
              //     child: Image.asset(testImage),
              //   );
              // },
              // )
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              icon: Icons.file_upload,
              title: "Upload Image",
              onclick: () async {
                Uint8List image = await ImagePickerWeb.getImageAsBytes();

                setState(() {
                  imageFile = image;
                  imageAvailable = true;
                });
              },
            ),
            SizedBox(
              width: 10,
            ),
            CustomButton(
              icon: Icons.file_download,
              title: "Get prediction",
              onclick: () async {
                if (imageFile != null || samplefile != null) {
                  dynamic result =
                      await httpService.jsonPrediction(imageFile ?? samplefile);
                  List list = result["data"];
                  code = """import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screen(),
    );
  }
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    var elements = $list;

    var new_height = height / 2;
    var new_width = width / 2;
    int count = 0;

    //color dict
    Map colorMap = {0:Colors.grey ,11:Colors.red, 12:Colors.green, 13:Colors.blue};

    Map encoded = {
      "99": "a",
      "91": "b",
      "92": "c",
      "93": "d",
      "94": "e",
      "95": "f",
      "96": "g",
      "97": "h",
      "98": "i",
      "89": "j",
      "79": "k",
      "11": "l",
      "12": "m",
      "13": "n",
      "14": "o",
      "15": "p",
      "16": "q",
      "17": "r",
      "18": "s",
      "19": "t",
      "29": "u",
      "21": "v",
      "22": "w",
      "23": "x",
      "24": "y",
      "25": "z",
    };
   
    return Scaffold(
      
        body: ListView.builder(
          itemCount: elements.length,
          itemBuilder: (BuildContext ctx, int index){
    
              if (elements[index].length == 2){
                
                print(elements[index]);
                var xmin = max(1,elements[index][0][3] * width);
                var xmax = min(width, elements[index][0][5] * width) / 2;
                var ymin = max(1, elements[index][0][2] * height);
                var ymax = min(height, elements[index][0][4] * height) / 2;
                var ymax_ = 0.0;
                var color_index = elements[index][0][6];
                var color_value = colorMap[color_index];

                // text code
                String encodedText = elements[index][0][7].toString();
                String finalText;
                if (encodedText != "0") {
                List<String> textList = [];
                List<String> encodedString = encodedText.split("");
                int j = 0;
                for (int i = 2; i < encodedString.length + 1; i = i + 2) {
                  textList.add(encoded[encodedText.substring(j, i)]);
                  j = j + 2;
                }

                finalText = textList.join();
                print(finalText);
                } else {
                  finalText = "";
                }
                

                var xmin2 = max(1,elements[index][1][3] * width);
                var xmax2 = min(width, elements[index][1][5] * width) / 2;
                var ymin2 = max(1, elements[index][1][2] * height);
                var ymax2 = min(height, elements[index][1][4] * height) / 2;
                var ymax2_ = 0.0;
                var color_index2 = elements[index][1][6];
                var color_value2 = colorMap[color_index2];

                // text code
                String encodedText1 = elements[index][1][7].toString();
                String finalText1;
                if (encodedText1 != "0") {
                List<String> textList1 = [];
                List<String> encodedString1 = encodedText1.split("");
                int j1 = 0;
                for (int i = 2; i < encodedString1.length + 1; i = i + 2) {
                  textList1.add(encoded[encodedText1.substring(j1, i)]);
                  j1 = j1 + 2;
                }

                finalText1 = textList1.join();
                print(finalText1);
                } else {
                  finalText1 = "";
                }

                print("****");
                print(elements[index][0]);
                if (elements[index][0][1] == 4.0 && elements[index][1][1] == 4.0){
                    return SizedBox(
                      height: ymin,
                      child: Flex(direction: Axis.horizontal,
                      
                          children: [
                            Flexible(flex: 5,
                              child:  Padding(
                            padding: EdgeInsets.only(
                            top: ymin>ymax?ymin - ymax:ymax-ymin,
                            left: xmin<30?xmin/6:30,
                            //right: xmax<xmin?0:new_width-xmin
                            ),
                            child:new SizedBox(
                              
                              width: width>xmin?width-xmin:xmin-width, //button on left or right
                              height: ymax>ymin?ymax/2:ymin/2,
                              child: ElevatedButton(
                              
                                child: Center(child:Text(finalText ?? "",style:TextStyle(fontSize:20),),),
                                style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(                    
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                  side: BorderSide(color: Colors.red)
                                )
                              )
                            ),onPressed:(){ 
                             
                            },
                                
                              ),
                            ),
                          )

                            ),
                            Flexible(flex:5,child: 
                               Padding(
                  padding: EdgeInsets.only(
                            top: ymin2>ymax2?ymin2 - ymax2:ymax2-ymin2,
                            left: xmin<30?xmin/6:30,
                            //right: xmax<xmin?0:new_width-xmin
                            ),
                            child:new SizedBox(
                              
                              width: width>xmin2?width-xmin2:xmin2-width, //button on left or right
                              height: ymax2>xmax2?xmax2/2:ymax2/2,
                              child: ElevatedButton(
                              
                                child: Center(child:Text(finalText1 ?? "",style:TextStyle(fontSize:20),),),
                                style: ButtonStyle(

                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                  side: BorderSide(color: Colors.red)
                                )
                              )
                            ),onPressed:(){
                              
                              
                            },
                                
                              ),
                            ),
                  )
                            )
                            

                          ],
                      ),
                    );
                }
                // if (index > 0){
                //   ymax2 = min(height, element[index-1][4] * height);
                

                // }
                else if (elements[index][0][1] == 1.0 && elements[index][1][1] == 1.0){
                   print("********");
                   print("iinside double container");
                   return Flex(direction: Axis.horizontal,
                   
                       children: [
                        Flexible(flex:5,child:Padding(
                  padding: EdgeInsets.only(
                    //top: ymin>ymax2?ymin-ymax2:ymax2-ymin
                       top:ymin>ymax?(ymin)*0.2:(ymax),
                       left: xmax,
                       right: xmax<xmin?new_width-xmin:0
                       ),
                       child: Container(
                             color: color_value == null ? Colors.transparent : color_value,
                             height: ymax>xmax?xmax+20:ymax+20, // xmax
                             width:ymax>xmax?xmax+20:ymax+20, // xmax
                             child: Center(child:Text(finalText ?? "",style:TextStyle(fontSize:20),),),
                     
                    ),
                  ),
                ),
                         Flexible(flex:5,child:Padding(
                  padding: EdgeInsets.only(
                    //top: ymin>ymax2?ymin-ymax2:ymax2-ymin
                       top:ymin2>ymax2?(ymin2)*0.2:(ymax2),
                       left: xmin,
                       right: xmax2<xmin2?0:new_width-xmin2
                       ),
                       child: Container(
                             color: color_value2 == null ? Colors.transparent : color_value2,
                             height: ymax2>xmax2?xmax2:ymax2, // xmax
                             width:ymax2>xmax2?xmax2:ymax2, // xmax
                             child: Center(child:Text(finalText1 ?? "",style:TextStyle(fontSize:20),),),
                     
                    ),
                  ),
                )
                         

                       ],
                   );

                }
                else if (elements[index][0][1] == 2.0 && elements[index][1][1] == 2.0){
                   print("********");
                   print("iinside double container");
                   return Flex(direction: Axis.horizontal,
                   
                       children: [
                        Flexible(flex:5,child:Padding(
                  padding: EdgeInsets.only(
                    //top: ymin>ymax2?ymin-ymax2:ymax2-ymin
                       top:ymin>ymax?(ymin)*0.2:(ymax),
                       left: xmax,
                       right: xmax<xmin?new_width-xmin:0
                       ),
                       child: Container(
                             color: color_value,
                             height: ymax>xmax?xmax+20:ymax+20, // xmax
                             width:ymax>xmax?xmax+20:ymax+20, // xmax
                             child: Icon(
                            Icons.close,
                            size: 80,
                          )
                     
                    ),
                  ),
                ),
                         Flexible(flex:5,child:Padding(
                  padding: EdgeInsets.only(
                    //top: ymin>ymax2?ymin-ymax2:ymax2-ymin
                       top:ymin2>ymax2?(ymin2)*0.2:(ymax2),
                       left: xmin,
                       right: xmax2<xmin2?0:new_width-xmin2
                       ),
                       child: Container(
                             color: color_value,
                             height: ymax2>xmax2?xmax2:ymax2, // xmax
                             width:ymax2>xmax2?xmax2:ymax2, // xmax
                             child:  Icon(
                            Icons.close,
                            size: 80,
                          )
                     
                    ),
                  ),
                )
                         

                       ],
                   );

                }


              }
              if (elements[index].length == 1){
                print(elements[index]);
                if (elements[index][0][1] == 1.0){
                  var xmin = max(1,elements[index][0][3] * width);
                  var xmax = min(width, elements[index][0][5] * width) / 2;
                  var ymin = max(1, elements[index][0][2] * height);
                  var ymax = min(height, elements[index][0][4] * height) / 2;
                  var ymax2 = 0.0;
                  var color_index = elements[index][0][6];
                  var color_value = colorMap[color_index];
                  // if (index > 0){
                  //   ymax2 = min(height, element[0][4] * height);
                  

                  // }
                  return Flexible(flex:5,child:Padding(
                  padding: EdgeInsets.only(
                    //top: ymin>ymax2?ymin-ymax2:ymax2-ymin
                          top:ymin>ymax?(ymin)*0.2:(ymax),
                          left: xmin,
                          right: xmax<xmin?0:new_width-xmin
                          ),
                          child: Container(
                                color: color_value,
                                height: ymax>xmax?xmax:ymax, // xmax
                                width:ymax>xmax?xmax:ymax, // xmax
                        
                    ),
                  ),
                );
                  
                }
                if (elements[index][0][1] == 2.0){
                  var xmin = max(1,elements[index][0][3] * width);
                  var xmax = min(width, elements[index][0][5] * width) / 2;
                  var ymin = max(1, elements[index][0][2] * height);
                  var ymax = min(height, elements[index][0][4] * height) / 2;
                  var ymax2 = 0.0;
                  var color_index = elements[index][0][6];
                  var color_value = colorMap[color_index];
                  // if (index > 0){
                  //   ymax2 = min(height, element[0][4] * height);
                  

                  // }
                  return Flexible(flex:5,child:Padding(
                  padding: EdgeInsets.only(
                    //top: ymin>ymax2?ymin-ymax2:ymax2-ymin
                          top:ymin>ymax?(ymin)*0.2:(ymax),
                          left: xmin,
                          right: xmax<xmin?0:new_width-xmin
                          ),
                          child: Container(
                                color: color_value,
                                height: ymax>xmax?xmax:ymax, // xmax
                                width:ymax>xmax?xmax:ymax, // xmax
                                child:  Icon(
                            Icons.close,
                            size: 80,
                          ),
                        
                    ),
                  ),
                );
                  
                }
              }
              if (elements[index][0][1] == 4.0){
                var xmin = max(1,elements[index][0][3] * width);
                var xmax = min(width, elements[index][0][5] * width) / 2;
                var ymin = max(1, elements[index][0][2] * height);
                var ymax = min(height, elements[index][0][4] * height) / 2;
                var ymax_ = 0.0;
                var color_index = elements[index][0][6];
                var color_value = colorMap[color_index];
             
                return Flexible(flex:5,child: 
                               Padding(
                  padding: EdgeInsets.only(
                           
                            top: ymin>ymax?ymin*0.09:ymax/6,
                            left: xmin<30?xmin/6:30,
                            //right: xmax<xmin?0:new_width-xmin
                            ),
                            child:new SizedBox(
                              
                              width: width>xmin?width-xmin:xmin-width, //button on left or right
                              height: ymax>xmax?xmax/2:ymax/2,
                              child: ElevatedButton(
                              
                                child: Text(''),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                  color_value == null
                                      ? Colors.transparent
                                      : color_value),

                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                  side: BorderSide(color: Colors.red)
                                )
                              )
                            ),onPressed:(){
                              
                              
                            },
                                
                              ),
                            ),
                  )
                            );


              }

               if (elements[index][0][1] == 0.0){
                var xmin = max(1,elements[index][0][3] * width);
                var xmax = min(width, elements[index][0][5] * width) / 2;
                var ymin = max(1, elements[index][0][2] * height);
                var ymax = min(height, elements[index][0][4] * height) / 2;
                var color_index = elements[index][0][6];
                var color_value = colorMap[color_index];
                
                
                  return Padding(
                    padding: EdgeInsets.only(top:10),
                    child: Align(alignment:Alignment.bottomRight ,child: FloatingActionButton( backgroundColor: color_value,onPressed: (){},)),
                  );
                


              }
              


            
            return Container();
          }
    ));
  }
}

""";
                  //print(code);
                  //print(value);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SecondScreen(
                              bounded_image:
                                  imageFile != null ? imageFile : samplefile,
                              generatedCode: code,
                            )),
                  );
                } else {
                  Fluttertoast.showToast(msg: "please select image first");
                }
              },
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
