import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:litmus_cx_library/RequestResponse/feedback_request.dart';
import 'package:litmus_cx_library/litmus_cx_library.dart';
import 'package:litmus_cx_library/requestResponse/feedback_resounse.dart';
import 'package:litmus_cx_library_example/pages/feedbackPage.dart';
import 'package:webviewx/webviewx.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _key = GlobalKey();
  FeedbackRequest request = FeedbackRequest();
  String isGenerateShortUrl = "true";
  String _chosenValue = 'Staging';
  late WebViewXController webviewController;
  Map<String, String> customParams = {};
  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  Map servers = {
    "Staging": "https://staging.litmusworld.com/rateus",
    "Production": "https://dashboard.litmusworld.com/rateus",
    "Production India": "https://dashboard-india.litmusworld.com/rateus",
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Feedback',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _key,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: getFormUI(),
      ),
    );
  }

  Widget getFormUI() {
    return ListView(
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      primary: true,
      children: <Widget>[
        //Name
        TextFormField(
          onSaved: (newValue) {
            if (newValue!.isNotEmpty) {
              request.name = newValue;
            } else {
              request.name = null;
            }
          },
          decoration: InputDecoration(
              hintText: 'Name',
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 15,
                  color: Colors.greenAccent,
                ),
                borderRadius: BorderRadius.circular(20.0),
              )),
          validator: (value) {
            String pattern = r'(^[a-zA-Z ]*$)';
            RegExp regExp = RegExp(pattern);
            if (!regExp.hasMatch(value!)) {
              return "Name must be a-z and A-Z";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 15,
        ),
        //Mobile number
        TextFormField(
          onSaved: (newValue) {
            if (newValue!.isNotEmpty) {
              request.userPhone = newValue;
            } else {
              request.userPhone = null;
            }
          },
          decoration: InputDecoration(
              hintText: 'Mobile Number',
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 15,
                  color: Colors.greenAccent,
                ),
                borderRadius: BorderRadius.circular(20.0),
              )),
          keyboardType: TextInputType.phone,
          validator: (value) {
            String patttern = r'(^[0-9]*$)';
            RegExp regExp = RegExp(patttern);
            if (value!.isNotEmpty && value.length != 10) {
              return "Mobile number must 10 digits";
            } else if (!regExp.hasMatch(value!)) {
              return "Mobile Number must be digits";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 15,
        ),
        //Email id
        TextFormField(
          onSaved: (newValue) {
            if (newValue!.isNotEmpty) {
              request.userEmail = newValue;
            } else {
              request.userEmail = null;
            }
          },
          decoration: InputDecoration(
              hintText: 'Email ID',
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 15,
                  color: Colors.greenAccent,
                ),
                borderRadius: BorderRadius.circular(20.0),
              )),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            String pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp = RegExp(pattern);
            if (value == null || value.isEmpty) {
              return "Email ID is Required";
            } else if (!regExp.hasMatch(value!)) {
              return "Invalid Email";
            } else {
              return null;
            }
          },
        ),
        const SizedBox(
          height: 15,
        ),
        //AppId
        TextFormField(
          onSaved: (newValue) {
            if (newValue!.isNotEmpty) {
              request.appId = newValue;
            } else {
              request.appId = null;
            }
          },
          decoration: InputDecoration(
              hintText: 'App ID',
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 15,
                  color: Colors.greenAccent,
                ),
                borderRadius: BorderRadius.circular(20.0),
              )),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "App ID is Required";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 15,
        ),
        //Customer Id
        TextFormField(
          onSaved: (newValue) {
            if (newValue!.isNotEmpty) {
              request.customerId = newValue;
            } else {
              request.customerId = null;
            }
          },
          decoration: InputDecoration(
              hintText: 'Customer ID',
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 15,
                  color: Colors.greenAccent,
                ),
                borderRadius: BorderRadius.circular(20.0),
              )),
        ),
        const SizedBox(
          height: 15,
        ),
        //generate short Url
        const Text(
          "Generate Short Url",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: RadioListTile<String>(
                  title: const Text('True'),
                  value: "true",
                  groupValue: isGenerateShortUrl,
                  onChanged: (value) {
                    setState(() {
                      isGenerateShortUrl = value.toString();
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<String>(
                  title: const Text('False'),
                  value: 'false',
                  groupValue: isGenerateShortUrl,
                  onChanged: (value) {
                    setState(() {
                      isGenerateShortUrl = value.toString();
                    });
                  },
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        //Select server
        const Text(
          "Select Server",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
              hintText: "Select Server",
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 15,
                  color: Colors.greenAccent,
                ),
                borderRadius: BorderRadius.circular(20.0),
              )),
          value: _chosenValue,
          items: <String>[
            'Staging',
            'Production',
            'Production India',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _chosenValue = value.toString();
            });
          },
        ),
        const SizedBox(
          height: 15,
        ),
        //generate short Url
        Row(
          children: [
            const Text(
              "Add Custom Element (*map values only)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            FloatingActionButton.small(
              backgroundColor: Colors.blueAccent,
              onPressed: () {},
              child: const Icon(
                Icons.add_outlined,
                size: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: keyController,
                      decoration: InputDecoration(
                          hintText: "Element key",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 15,
                              color: Colors.greenAccent,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: valueController,
                      onSaved: (_) {
                        if (keyController.text.isNotEmpty &&
                            valueController.text.isNotEmpty) {
                          customParams[keyController.text] =
                              valueController.text;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Element value",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 15,
                              color: Colors.greenAccent,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15.0),
        OutlinedButton(
          onPressed: () async {
            if (_key.currentState!.validate()) {
              _key.currentState!.save();

              request.isGenerateShortUrl = isGenerateShortUrl;
              // server
              var result = await LitmusCxLibrary.getFeedback(
                  baseUrl: servers[_chosenValue],
                  appId: request.appId ?? '',
                  userEmail: request.userEmail ?? '',
                  isGenerateShortUrl:
                      request.isGenerateShortUrl == "true" ? true : false,
                  userId: request.customerId,
                  userName: request.name,
                  userPhone: int.tryParse(request.userPhone ?? ''),
                  customParams: customParams);
              if (result is FeedbackResponse) {
                Uri url = Uri.parse(result.data!.longUrl ?? '');
                if (url.queryParameters['utm_term'] != 'custom') {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: const Text("Confirmation"),
                          content: const Text(
                              "Do you want to see content in full screen"),
                          actions: [
                            TextButton(
                                child: const Text("Yes"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  showInFullScreen(
                                      true, result.data!.shortUrl.toString());
                                }),
                            TextButton(
                                child: const Text("No"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  showInFullScreen(
                                      false, result.data!.shortUrl.toString());
                                }),
                          ],
                        );
                      }));
                } else {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: const Text("Submitted"),
                          content: const Text(
                              "Your feedback has been already submitted."),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      }));
                }
              } else {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        title: const Text("Response Error"),
                        content: Text(result.data!.errorMessage.toString()),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    }));
              }
            }
          },
          child: const Text('Submit'),
        )
      ],
    );
  }

  showInFullScreen(bool fullScreen, String url) {
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
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * .75,
            width: MediaQuery.of(context).size.width * .75,
            child: kIsWeb
                ? Stack(
                    children: <Widget>[
                      Positioned(
                        top: 30,
                        child: WebViewX(
                          height:
                              (MediaQuery.of(context).size.height * .75) - 30,
                          width: MediaQuery.of(context).size.width * .75,
                          // width: 400,
                          // height: 470,
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
                        height: (MediaQuery.of(context).size.height * .75) - 30,
                        width: MediaQuery.of(context).size.width * .75,
                        // width: 400,
                        // height: 500,
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

class Constants {
  static String baseUrlProduction = "https://dashboard.litmusworld.com/rateus";
  static String baseUrlStaging = "https://staging.litmusworld.com/rateus";
  static String baseUrlIndiaProduction =
      "https://dashboard-india.litmusworld.com/rateus";
}
