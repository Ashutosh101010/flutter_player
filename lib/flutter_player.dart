library flutter_player;

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterPlayer extends StatelessWidget{


  final String streamName;
  String url="";
  FlutterPlayer({required this.streamName}){
    this.url="http://94.237.55.155/?url=ws://94.237.49.12:8000/live/${streamName}.flv";
  }

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return
      WebView(
        allowsInlineMediaPlayback: true,
        zoomEnabled: false,
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      );
  }}

