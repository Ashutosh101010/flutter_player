library flutter_player;

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
class FlutterPlayer extends StatelessWidget {

  String streamName;
  String url = "";
  String quality="";

  FlutterPlayer({required this.streamName}) {
    this.url =
    "http://94.237.55.155/?url=ws://94.237.49.12:8000/live/${streamName}.flv";
  }

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InAppWebView(
      initialUrlRequest:
      URLRequest(url: Uri.parse(url)),
      // initialFile: "assets/index.html",
      initialUserScripts: UnmodifiableListView<UserScript>([]),
      initialOptions: options,
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
      onLoadStart: (controller, url) {},
      androidOnPermissionRequest:
          (controller, origin, resources) async {
        return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT);
      },
      shouldOverrideUrlLoading:
          (controller, navigationAction) async {
        var uri = navigationAction.request.url!;

        if (![
          "http",
          "https",
          "file",
          "chrome",
          "data",
          "javascript",
          "about"
        ].contains(uri.scheme)) {
          if (await canLaunch(url)) {
            // Launch the App
            await launch(
              url,
            );
            // and cancel the request
            return NavigationActionPolicy.CANCEL;
          }
        }

        return NavigationActionPolicy.ALLOW;
      },
      onLoadStop: (controller, url) async {},
      onLoadError: (controller, url, code, message) {

      },
      onProgressChanged: (controller, progress) {

      },
      onUpdateVisitedHistory: (controller, url, androidIsReload) {

      },
      onConsoleMessage: (controller, consoleMessage) {
        print(consoleMessage);
      },
    );
  }
}
