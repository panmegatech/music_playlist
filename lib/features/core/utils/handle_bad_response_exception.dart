import 'package:music_playlist/features/core/error/exception.dart';
import 'package:music_playlist/features/core/utils/log_color.dart';

handleBadResponseException(int? statusCode) {
  if (statusCode == 500) {
    logError("Internal Server Error: 500");
    return ServerException("Internal Server Error");
  }

  if (statusCode == 404) {
    logError("DataNotFoundException: 404");
    return DataNotFoundException();
  }
  if (statusCode == 403) {
    logError("ForbiddenException: 403");
    return ForbiddenException();
  }
  if (statusCode == 401) {
    logError("UnauthorizedException: 401");
    return UnauthorizedException();
  }

  if (statusCode == 400) {
    logError("BadRequestException: 400");
    return BadRequestException("Invalid request parameters");
  }

  logError("UnexpectedException: $statusCode");
  return UnexpectedException();
}
