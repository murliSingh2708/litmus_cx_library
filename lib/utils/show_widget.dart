import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../requestResponse/feedback_resounse.dart';
import 'feedback_page.dart';
import 'package:webviewx/webviewx.dart';

class Widgets {
  late WebViewXController webviewController;

  showWebView(BuildContext context, FeedbackResponse result, bool isFullScreen,
      bool isDarkMode) {
    Uri url = Uri.parse(result.data!.longUrl ?? '');
    showInFullScreen(
        context, isFullScreen, result.data!.shortUrl.toString(), isDarkMode);
  }

  showInFullScreen(
      BuildContext context, bool fullScreen, String url, bool isDark) {
    if (fullScreen) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FeedbackPage(
                url: url,
                isDarkMode: isDark,
              )));
    } else {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: kIsWeb
              ? SizedBox(
                  height: (MediaQuery.of(context).size.height * .70),
                  width: MediaQuery.of(context).size.width * .60,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topRight,
                        height: 30,
                        color: !isDark ? Colors.black : Colors.white,
                        padding: const EdgeInsets.only(top: 5, right: 10),
                        child: GestureDetector(
                          child: Icon(
                            Icons.cancel,
                            size: 20.0,
                            color: isDark ? Colors.black : Colors.white,
                          ),
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Expanded(
                        child: WebViewX(
                          height:
                              (MediaQuery.of(context).size.height * .70) - 30,
                          width: MediaQuery.of(context).size.width * .60,
                          ignoreAllGestures: false,
                          initialContent: url,
                          onWebViewCreated: (controller) =>
                              webviewController = controller,
                          javascriptMode: JavascriptMode.unrestricted,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: (MediaQuery.of(context).size.height * .65),
                  width: MediaQuery.of(context).size.width * .90,
                  child: Stack(
                    children: <Widget>[
                      WebViewX(
                        height: MediaQuery.of(context).size.height * .65,
                        width: MediaQuery.of(context).size.width * .90,
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
                          child: Icon(
                            Icons.cancel,
                            size: 20.0,
                            color: isDark ? Colors.black : Colors.white,
                          ),
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: GestureDetector(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20.0,
                            color: isDark ? Colors.black : Colors.white,
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
