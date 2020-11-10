import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeDetails extends StatefulWidget {
  final String url;

  RecipeDetails({Key key, @required this.url}) : super(key: key);

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
  //   return WebviewScaffold(
  //     url: widget.url,
  //     appBar: AppBar(
  //       title: Text("Recipe View"),
  //       elevation: 1
  //     ),
  // );
    return Scaffold(
      appBar: AppBar(title: Text("Recipe View"), elevation: 1,),
      body: WebView(
        initialUrl: widget.url,
      )
    );
    // return WebView(
    //   initialUrl: widget.url,
    // );
  }
}
