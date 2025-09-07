import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:music_playlist/features/core/error/exception.dart';
import 'package:music_playlist/features/core/utils/handle_bad_response_exception.dart';
import 'package:music_playlist/features/core/utils/log_color.dart';
import 'package:music_playlist/features/music/data/models/playlist_model.dart';
import 'package:music_playlist/features/music/domain/music_config_provider.dart';

abstract class MusicRemoteDataSource {
  Future<PlaylistModel> playlist();
}

class MusicRemoteDataSourceImpl extends MusicRemoteDataSource {
  final MusicConfigProvider configProvider;
  final Dio dio;

  MusicRemoteDataSourceImpl({
    required this.configProvider,
    required this.dio,
  });

  @override
  Future<PlaylistModel> playlist() async {
    dio.options.connectTimeout =
        Duration(milliseconds: configProvider.requestTimeout);
    dio.options.receiveTimeout =
        Duration(milliseconds: configProvider.requestTimeout);

    // String body = jsonEncode({});

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $token',
    };

    try {
      final endpointUrl = configProvider.getPlaylistUrl();

      logWarning("enpointUrl (getPlaylistUrl): $endpointUrl");

      await Future.delayed(const Duration(milliseconds: 500));

      //!dont remove real request
      final response = await dio.get(
        endpointUrl,
      );

      // final Response response = Response(
      //   requestOptions: RequestOptions(headers: {
      //     'Content-Type': 'application/json',
      //     'Accept': 'application/json',
      //     'Authorization': 'Bearer $token',
      //   }),
      //   statusCode: 200,
      //   data: Mock.carAvailableJson,
      // );

      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        final data = response.data;
        logInfo("response (data/getPlaylistUrl): $data");
        // final List<dynamic> rawList = jsonDecode(data);

        //? wrap key "playlist" becuase the reponse is List not Object (Mock)
        final Map<String, dynamic> wrapped = {
          "playlist": data,
        };
        return PlaylistModel.fromJson(wrapped);
      } else {
        throw UnexpectedException("status fail : ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        logError('(Dio) Connection refused: ${e.message}');

        throw ServerException();
      } else if (e.type == DioExceptionType.connectionTimeout) {
        logError('(Dio) Connection timed out: ${e.message}');

        throw TimeoutException(
            "Request cancelled after ${configProvider.requestTimeout} seconds");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        logError('(Dio) Response timed out: ${e.message}');
        throw TimeoutException(
            "Request cancelled after ${configProvider.requestTimeout} seconds");
      } else if (e.type == DioExceptionType.badResponse) {
        // Handle server error (e.g., 500, 404)

        logError("(Dio) badResponse: ${e.response?.data}");

        throw handleBadResponseException(e.response?.statusCode);
      } else if (e.type == DioExceptionType.cancel) {
        // Handle server error (e.g., 500, 404)
        logError(
            '(Dio) Connection Timeout [cancel]: ${e.response?.statusCode} - ${e.response?.statusMessage}');

        throw TimeoutException(
            "Request cancelled after ${configProvider.requestTimeout} seconds");
      } else {
        // Handle other types of errors
        logError('(Dio) Unexpected error: ${e.message}');
        throw UnauthorizedException();
      }
    } catch (e, s) {
      logError("remote (error): $e \n\n $s");
      rethrow;
    }
  }
}
