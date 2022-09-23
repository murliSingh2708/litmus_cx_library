import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:litmus_cx_library/requestResponse/feedback_resounse.dart';
import 'package:litmus_cx_library/utils/feedback_page.dart';
import 'package:webviewx/webviewx.dart';

class Widgets {
  late WebViewXController webviewController;

  showWebView(
      BuildContext context, FeedbackResponse result, bool isFullScreen) {
    Uri url = Uri.parse(result.data!.longUrl ?? '');
    showInFullScreen(context, isFullScreen, result.data!.shortUrl.toString());
  }

  showInFullScreen(BuildContext context, bool fullScreen, String url) {
    if (fullScreen) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FeedbackPage(
                url: url,
              )));
    } else {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            height: (MediaQuery.of(context).size.height * .60),
            width: MediaQuery.of(context).size.width * .85,
            child: kIsWeb
                ? Stack(
                    children: <Widget>[
                      Positioned(
                        top: 30,
                        child: WebViewX(
                          height:
                              (MediaQuery.of(context).size.height * .60) - 30,
                          width: MediaQuery.of(context).size.width * .85,
                          ignoreAllGestures: false,
                          initialContent: url,
                          onWebViewCreated: (controller) =>
                              webviewController = controller,
                          javascriptMode: JavascriptMode.unrestricted,
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 10,
                        child: GestureDetector(
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
                    children: <Widget>[
                      WebViewX(
                        height: (MediaQuery.of(context).size.height * .60),
                        width: MediaQuery.of(context).size.width * .85,
                        ignoreAllGestures: false,
                        initialContent: url,
                        onWebViewCreated: (controller) =>
                            webviewController = controller,
                        javascriptMode: JavascriptMode.unrestricted,
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
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
                        child: GestureDetector(
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
        ),
      );
    }
  }
}
