class HeadersAPI {
  final token;
  HeadersAPI({this.token});

  Map<String, String> getHeaders() {
    return {
      "Content-Type": "application/json",
      "Authentication-Token": "${this.token}"
    };
  }
}
