import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:helia_frontend/app/data/enviroments/enviroment.dart';
import 'package:helia_frontend/app/utils/exceptions/http_exception.dart';

const String _endpoint = Environment.server;

class InterceptorToken extends InterceptorsWrapper {
  final Future<String> Function() bearerToken;

  InterceptorToken({
    required this.bearerToken,
  });

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({"Authorization": await bearerToken()});

    handler.next(options);
  }
}

class NetworkUtil {
  static final NetworkUtil _instance = NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  static BaseOptions options = BaseOptions(
    receiveTimeout: const Duration(milliseconds: Environment.httpTimeout),
    connectTimeout: const Duration(milliseconds: Environment.httpTimeout),
  );
  final Dio _dio = Dio(options);

  Future<dynamic> get({
    String url = _endpoint,
    String path = '',
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic> headers = const {},
  }) async {
    try {
      var res = await _dio.get(
        '$url/$path',
        options: Options(
          sendTimeout:
              sendTimeout != null ? Duration(milliseconds: sendTimeout) : null,
          receiveTimeout: receiveTimeout != null
              ? Duration(milliseconds: receiveTimeout)
              : null,
          responseType: ResponseType.json,
          contentType: Headers.jsonContentType,
          headers: headers,
        ),
      );
      return res.data;
    } on DioException catch (e) {
      if (e.response != null) {
        final int? statusCode = e.response?.statusCode;

        switch (statusCode) {
          case 400:
            throw BadRequestException(e.response?.statusMessage.toString());
          case 401:
          case 403:
            throw UnauthorizedException(e.response?.statusMessage.toString());
          case 404:
            throw NotFoundException(e.response?.statusMessage.toString());
          case 500:
          default:
            throw FetchDataException(
                'Error occurred while Communication with Server with StatusCode : $statusCode');
        }
      } else {
        if ([
          DioExceptionType.connectionTimeout,
          DioExceptionType.receiveTimeout,
          DioExceptionType.sendTimeout
        ].contains(e.type)) {
          throw TimeoutException('Tiempo de espera agotado. '
              'Detalles: ${e.message} - ${e.requestOptions.path}');
        }
        if ([
          SocketException,
          HandshakeException,
        ].contains(e.error.runtimeType)) {
          throw SocketException(e.message ?? 'SocketException');
        }
        throw FetchDataException('Error occurred while Communication '
            'with Server ${e.requestOptions.baseUrl} with StatusCode : '
            'Error:${e.message}]');
      }
    }
  }

  Future<dynamic> post({
    String url = _endpoint,
    String path = '',
    dynamic body,
    Map<String, dynamic> headers = const {},
    String contentType = Headers.jsonContentType,
    int? sendTimeout,
    int? receiveTimeout,
  }) async {
    try {
      var res = await _dio.post(
        '$url/$path',
        data: body,
        options: Options(
          sendTimeout:
              sendTimeout != null ? Duration(milliseconds: sendTimeout) : null,
          receiveTimeout: receiveTimeout != null
              ? Duration(milliseconds: receiveTimeout)
              : null,
          responseType: ResponseType.json,
          contentType: contentType,
          headers: headers,
        ),
      );
      return res.data;
    } on DioException catch (e) {
      if (e.response != null) {
        final int? statusCode = e.response?.statusCode;

        switch (statusCode) {
          case 400:
            throw BadRequestException(e.response?.statusMessage.toString());
          case 401:
          case 403:
            throw UnauthorizedException(e.response?.statusMessage.toString());
          case 404:
            throw NotFoundException(e.response?.statusMessage.toString());
          case 422:
            throw FetchDataException(statusCode.toString());
          case 500:
          default:
            throw FetchDataException(
                'Error occurred while Communication with Server with StatusCode : $statusCode');
        }
      } else {
        if ([
          DioExceptionType.connectionTimeout,
          DioExceptionType.receiveTimeout,
          DioExceptionType.sendTimeout
        ].contains(e.type)) {
          throw TimeoutException('Tiempo de espera agotado. '
              'Detalles: ${e.message} - ${e.requestOptions.path}');
        }
        if ([
          SocketException,
          HandshakeException,
        ].contains(e.error.runtimeType)) {
          throw SocketException(e.message ?? 'SocketException');
        }
        throw FetchDataException('Error occurred while Communication with '
            'Server ${e.requestOptions.baseUrl} with '
            'StatusCode : Error:${e.message}]');
      }
    }
  }

  Future<dynamic> put(
      {String url = _endpoint, String path = '', dynamic body}) async {
    try {
      var res = await _dio.put(
        '$url/$path',
        data: json.encode(body),
        options: Options(
          responseType: ResponseType.json,
          contentType: Headers.jsonContentType,
        ),
      );

      return res.data;
    } on DioException catch (e) {
      if (e.response != null) {
        final int? statusCode = e.response?.statusCode;

        switch (statusCode) {
          case 400:
            throw BadRequestException(e.response?.statusMessage.toString());
          case 401:
          case 403:
            throw UnauthorizedException(e.response?.statusMessage.toString());
          case 404:
            throw NotFoundException(e.response?.statusMessage.toString());
          case 500:
          default:
            throw FetchDataException(
                'Error occurred while Communication with Server with StatusCode : $statusCode');
        }
      } else {
        if ([
          DioExceptionType.connectionTimeout,
          DioExceptionType.receiveTimeout,
          DioExceptionType.sendTimeout
        ].contains(e.type)) {
          throw TimeoutException('Tiempo de espera agotado. '
              'Detalles: ${e.message} - ${e.requestOptions.path}');
        }
        if ([
          SocketException,
          HandshakeException,
        ].contains(e.error.runtimeType)) {
          throw SocketException(e.message ?? 'SocketException');
        }
        throw FetchDataException(
            'Error occurred while Communication with Server ${e.requestOptions.baseUrl} with StatusCode : Error:${e.message}]');
      }
    }
  }

  Future<dynamic> patch(
      {String url = _endpoint, String path = '', dynamic body}) async {
    try {
      var res = await _dio.patch(
        '$url/$path',
        data: json.encode(body),
        options: Options(
          responseType: ResponseType.json,
          contentType: Headers.jsonContentType,
        ),
      );
      return res.data;
    } on DioException catch (e) {
      if (e.response != null) {
        final int? statusCode = e.response?.statusCode;

        switch (statusCode) {
          case 400:
            throw BadRequestException(e.response?.statusMessage.toString());
          case 401:
          case 403:
            throw UnauthorizedException(e.response?.statusMessage.toString());
          case 404:
            throw NotFoundException(e.response?.statusMessage.toString());
          case 500:
          default:
            throw FetchDataException(
                'Error occurred while Communication with Server with StatusCode : $statusCode');
        }
      } else {
        if ([
          DioExceptionType.connectionTimeout,
          DioExceptionType.receiveTimeout,
          DioExceptionType.sendTimeout
        ].contains(e.type)) {
          throw TimeoutException('Tiempo de espera agotado. '
              'Detalles: ${e.message} - ${e.requestOptions.path}');
        }
        if ([
          SocketException,
          HandshakeException,
        ].contains(e.error.runtimeType)) {
          throw SocketException(e.message ?? 'SocketException');
        }
        throw FetchDataException(
            'Error occurred while Communication with Server ${e.requestOptions.baseUrl} with StatusCode : Error:${e.message}]');
      }
    }
  }
}
