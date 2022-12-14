import 'dart:convert';

import 'package:http/http.dart' as http;
import '../requestResponse/error_response.dart';
import '../requestResponse/feedback_resounse.dart';

import '../RequestResponse/feedback_request.dart';

class API {
  static getFeedbackApi(FeedbackRequest request) async {
    Map customBody = {
      "app_id": request.appId ?? "",
      "customer_id": request.customerId ?? '',
      "user_email": request.userEmail ?? '',
      "user_phone": request.userPhone ?? "9999999999",
      "is_generate_short_url": request.isGenerateShortUrl ?? "true",
      "name": request.name ?? "Some User Name",
    };
    Map params = request.optionalparams ?? {};
    if (params.length > 0) {
      request.optionalparams!.forEach((key, value) {
        customBody[key] = value;
      });
    }

    final response = await http.post(
      Uri.parse(
          "${request.baseUrl}/api/feedbackrequests/generate_customer_feedback_url"),
      body: customBody,
    );
    if (response.statusCode == 200) {
      var success = jsonDecode(response.body)["data"]["error_message"];
      if (success == null) {
        return FeedbackResponse.fromJson(jsonDecode(response.body));
      } else {
        return ErrorResponse.fromJson(jsonDecode(response.body));
      }
    } else {
      return 'Failed with Exception';
    }
  }
}
