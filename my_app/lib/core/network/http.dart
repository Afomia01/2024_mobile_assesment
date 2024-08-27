import 'package:http/http.dart' as http;


class HttpClient {
  final http.Client client;
  final Future<http.MultipartRequest> Function(String, String) multipartRequestFactory;

  HttpClient({
    required this.client,
    required this.multipartRequestFactory,
  });

  Future<http.Response> get(String url) async {
    final response = await client.get(Uri.parse(url));
    _checkResponse(response);
    return response;
  }

  Future<http.Response> post(String url, {Map<String, String>? headers, Object? body}) async {
    final response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    _checkResponse(response);
    return response;
  }

  Future<http.Response> put(String url, {Map<String, String>? headers, Object? body}) async {
    final response = await client.put(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    _checkResponse(response);
    return response;
  }

  Future<http.Response> delete(String url, {Map<String, String>? headers}) async {
    final response = await client.delete(
      Uri.parse(url),
      headers: headers,
    );
    _checkResponse(response);
    return response;
  }

  Future<http.MultipartRequest> createMultipartRequest(String method, String url) {
    return multipartRequestFactory(method, url);
  }

  void _checkResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(response.reasonPhrase ?? 'Unknown error', response.statusCode);
    }
  }
}

class HttpException implements Exception {
  final String message;
  final int statusCode;

  HttpException(this.message, this.statusCode);

  @override
  String toString() => 'HttpException: $message (status code: $statusCode)';
}
