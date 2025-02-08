import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsViewScreen extends StatelessWidget {
  final String url;

  const NewsViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NewsViewWidget(url: url),
      ),
    );
  }
}

class NewsViewWidget extends StatefulWidget {
  final String url;

  const NewsViewWidget({Key? key, required this.url}) : super(key: key);

  @override
  _NewsViewWidgetState createState() => _NewsViewWidgetState();
}

class _NewsViewWidgetState extends State<NewsViewWidget> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
