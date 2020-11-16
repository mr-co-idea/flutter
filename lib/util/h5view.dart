import 'dart:convert';

// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

//封装webview

class H5View extends WebView {
  H5View(
      {Key key,
      String localFileUrl,
      Function onWebViewCreated,
      @required String initialUrl,
      JavascriptMode javascriptMode = JavascriptMode.unrestricted})
      : super(
          key: key,
          // onWebViewCreated: onWebViewCreated,
          initialUrl: initialUrl,
        );

  static String localFileUrl;

  static loadHtml(String htmlPath) async {
    String _html = await rootBundle.loadString(htmlPath);
    final String _uri = Uri.dataFromString(_html,
            mimeType: 'text/html', encoding: Encoding.getByName('utf8'))
        .toString();
    return _uri;
  }

  void Function(WebViewController) onNewWebViewCreated(
      WebViewController webViewController) {
    super.onWebViewCreated(webViewController);
  }
}
