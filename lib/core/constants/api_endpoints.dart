class ApiEndpoints {
  // Base URL
  static const String baseUrl =
      'http://api.doaa-gadoo.com';

  // ── Auth ──────────────────────────────────────────────────────────────────
  static const String registerEndpoint = '/api/Account/Register';
  static const String loginEndpoint = '/api/Account/Login';

  // ── Headers ───────────────────────────────────────────────────────────────
  static const String contentTypeHeader = 'Content-Type';
  static const String acceptHeader = 'Accept';
  static const String authorizationHeader = 'Authorization';
  static const String applicationJson = 'application/json';
}
