// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class FeedbackPage extends StatefulWidget {
  final String url;
  final bool isDarkMode;
  const FeedbackPage({Key? key, required this.url, required this.isDarkMode})
      : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late WebViewXController webviewController;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: kIsWeb
            ? Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    height: 30,
                    padding: const EdgeInsets.only(
                      top: 5,
                      right: 10,
                    ),
                    color: !widget.isDarkMode ? Colors.black : Colors.white,
                    child: InkWell(
                      child: Icon(
                        Icons.cancel,
                        size: 20.0,
                        color: widget.isDarkMode ? Colors.black : Colors.white,
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Expanded(
                    child: WebViewX(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 30,
                      initialContent: widget.url,
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  WebViewX(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    initialContent: widget.url,
                    onWebViewCreated: (controller) =>
                        webviewController = controller,
                    javascriptMode: JavascriptMode.unrestricted,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      child: Icon(
                        Icons.cancel,
                        size: 20.0,
                        color: widget.isDarkMode ? Colors.black : Colors.white,
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20.0,
                        color: widget.isDarkMode ? Colors.black : Colors.white,
                      ),
                      onTap: () => webviewController.goBack(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
