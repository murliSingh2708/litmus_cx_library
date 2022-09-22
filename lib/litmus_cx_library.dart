// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:litmus_cx_library/RequestResponse/feedback_request.dart';
import 'package:litmus_cx_library/requestResponse/feedback_resounse.dart';
import 'package:litmus_cx_library/utils/apiCall.dart';

class LitmusCxLibrary {
  static getFeedback({
    required String baseUrl,
    required String appId,
    String? userId,
    String? userName,
    required String userEmail,
    Map<String, String>? customParams,
    int? userPhone,
    bool isGenerateShortUrl = false,
  }) async {
    FeedbackRequest request = FeedbackRequest();
    request.appId = appId;
    request.baseUrl = baseUrl;
    request.customerId = userId;
    request.isGenerateShortUrl = isGenerateShortUrl ? 'true' : "false";
    request.name = userName;
    request.optionalparams = customParams;
    request.userEmail = userEmail;
    request.userPhone = userPhone?.toString();

    var response = await API.getFeedbackApi(request);
    print(response.data!.longUrl.toString());
    return response;
  }
}
