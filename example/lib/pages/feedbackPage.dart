// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class FeedbackPage extends StatefulWidget {
  final String url;
  const FeedbackPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late WebViewXController webviewController;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      const AlertDialog(
        title: Text("WebView Loading..."),
        content: CircularProgressIndicator(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: kIsWeb
            ? Stack(
                children: [
                  Positioned(
                    top: 30,
                    child: WebViewX(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      initialContent: widget.url,
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 10,
                    child: InkWell(
                      child: const Icon(
                        Icons.cancel,
                        size: 20.0,
                        color: Colors.black,
                      ),
                      onTap: () => Navigator.of(context).pop(),
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
                      child: const Icon(
                        Icons.cancel,
                        size: 20.0,
                        color: Colors.black,
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: InkWell(
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20.0,
                        color: Colors.black,
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
