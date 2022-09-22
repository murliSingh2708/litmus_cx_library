class ErrorResponse {
  int? code;
  Data? data;

  ErrorResponse({this.code, this.data});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
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
  String? errorMessage;

  Data({this.code, this.errorMessage});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    errorMessage = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['error_message'] = errorMessage;
    return data;
  }
}
