import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:in_the_kloud_app/core/base/http_server_requests/ResultData.dart';
import 'package:in_the_kloud_app/core/base/models/master_model.dart';
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

class EndPointRequest {
  EndPoint endPoint;
  MasterModel? body;
  Map<String, String>? headers;

  HttpRequestMethod requestMethod;

  EndPointRequest(
      {required this.endPoint,
      this.body,
      this.headers,
      required this.requestMethod}) {
    headers ??= {};
    headers?.addAll(Constants.DeafualtHttpRequestHeaders);
  }

  Future<http.Response> _proceedWithRequest({http.Client? client}) {
    client ??= http.Client();
    var bodyJson = jsonEncode(body?.toJson()??{});
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
        return client.delete(endPoint.toUri(),
            headers: headers, body: bodyJson);
    }
  }

}

class WebApiHandler<RESPONSE_TYPE extends MasterModel> {

   RESPONSE_TYPE Function() responseCreator;


   EndPointRequest? _request;

  WebApiHandler.hi(this._request,this.responseCreator);

  // ResultData<RESPONSE_TYPE> getData(EndPointRequest _request) {
  //   try {
  //     var response = _request._proceedWithRequest();
  //     (RESPONSE_TYPE).fromJson({});
  //   } catch (e) {
  //
  //
  //   }
  // return ResultData.success();
  // }
}

typedef ResponseBuilder<S> = S Function();



Future<ResultData<RESPONSE_TYPE>> sentRequest<RESPONSE_TYPE extends MasterModel>(EndPointRequest request);



enum HttpRequestMethod { GET, POST, PATCH, PUT, DELETE }
