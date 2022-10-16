import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:in_the_kloud_app/resources/Strings.dart';
import 'package:in_the_kloud_app/resources/constants.dart';

class EndPoint {
  String absoluteUrl;

  String path;
  Map<String, dynamic>? queryParameters;

  EndPoint(
      {this.absoluteUrl = AppStrings.absoluteUrl,
      required this.path,
      this.queryParameters});

  Uri toUri() => Uri.https(absoluteUrl, path, queryParameters);
}

class WebApiRequest {
  EndPoint endPoint;
  Map<String, dynamic>? body;
  Map<String, String>? headers;

  HttpRequestMethod requestMethod;

  WebApiRequest(
      {required this.endPoint,
      this.body,
      this.headers,
      required this.requestMethod}) {
    headers ??= {};
    headers?.addAll(Constants.DeafualtHttpRequestHeaders);
  }

  Future<http.Response> proceedWithRequest({http.Client? client}) {
    client ??= http.Client();
    var bodyJson = jsonEncode(body);
    switch (requestMethod) {
      case HttpRequestMethod.GET:
        return client.get(endPoint.toUri(), headers: headers);
      case HttpRequestMethod.POST:
        return client.post(endPoint.toUri(), headers: headers, body: bodyJson);
      case HttpRequestMethod.PATCH:
        return client.patch(endPoint.toUri(), headers: headers, body: bodyJson);
      case HttpRequestMethod.PUT:
        return client.put(endPoint.toUri(), headers: headers, body: bodyJson);
      case HttpRequestMethod.DELETE:
        return client.delete(endPoint.toUri(), headers: headers, body: bodyJson);
    }
  }
}

enum HttpRequestMethod { GET, POST, PATCH, PUT, DELETE }
