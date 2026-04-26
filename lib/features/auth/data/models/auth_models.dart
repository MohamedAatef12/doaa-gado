class LoginResponseModel {
  final String accessToken;
  final String refreshToken;

  LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}

class RegisterResponseModel {
  final String accessToken;
  final String refreshToken;

  RegisterResponseModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}

class LoginRequestModel {
  final int code;
  final String mobile;

  LoginRequestModel({
    required this.code,
    required this.mobile,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'mobile': mobile,
    };
  }
}

class RegisterRequestModel {
  final String fullName;
  final String mobile;
  final DateTime birthdate;

  RegisterRequestModel({
    required this.fullName,
    required this.mobile,
    required this.birthdate,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'mobile': mobile,
      'birthdate': birthdate.toIso8601String().split('T')[0],
    };
  }
}

/// Generic wrapper as specified in the requirements
class BaseResponseModel<T> {
  final int statusCode;
  final String message;
  final T? data;

  BaseResponseModel({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    // If the response is wrapped with statusCode and data
    if (json.containsKey('statusCode')) {
      return BaseResponseModel(
        statusCode: json['statusCode'] ?? 0,
        message: json['message'] ?? '',
        data: json['data'] != null ? fromJsonT(json['data']) : null,
      );
    }
    
    // If the response is unwrapped (data is at the root)
    return BaseResponseModel(
      statusCode: 200, // Assume 200 if we got a map and no error wrapper
      message: 'Success',
      data: fromJsonT(json),
    );
  }
}
