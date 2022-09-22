class FeedbackResponse {
  int? code;
  Data? data;

  FeedbackResponse({this.code, this.data});

  FeedbackResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? code;
  bool? hasResponded;
  String? feedbackRequestToken;
  bool? isDuplicate;
  String? shortUrl;
  String? longUrl;

  Data(
      {this.code,
      this.hasResponded,
      this.feedbackRequestToken,
      this.isDuplicate,
      this.shortUrl,
      this.longUrl});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    hasResponded = json['has_responded'];
    feedbackRequestToken = json['feedback_request_token'];
    isDuplicate = json['is_duplicate'];
    shortUrl = json['short_url'];
    longUrl = json['long_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['has_responded'] = hasResponded;
    data['feedback_request_token'] = feedbackRequestToken;
    data['is_duplicate'] = isDuplicate;
    data['short_url'] = shortUrl;
    data['long_url'] = longUrl;
    return data;
  }
}
