class FeedbackRequest {
  String? baseUrl;
  String? appId;
  String? customerId;
  String? userEmail;
  String? userPhone;
  String? isGenerateShortUrl;
  String? name;
  Map<String, String>? optionalparams = {};

  FeedbackRequest(
      {this.appId,
      this.baseUrl,
      this.customerId,
      this.userEmail,
      this.userPhone,
      this.isGenerateShortUrl,
      this.name,
      this.optionalparams});

  // FeedbackRequest.fromJson(Map<String, dynamic> json) {
  //   appId = json['app_id'];
  //   customerId = json['customer_id'];
  //   userEmail = json['user_email'];
  //   userPhone = json['user_phone'];
  //   isGenerateShortUrl = json['is_generate_short_url'];
  //   name = json['name'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['app_id'] = appId;
  //   data['customer_id'] = customerId;
  //   data['user_email'] = userEmail;
  //   data['user_phone'] = userPhone;
  //   data['is_generate_short_url'] = isGenerateShortUrl;
  //   data['name'] = name;
  //   return data;
  // }
}
