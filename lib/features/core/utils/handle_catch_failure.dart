import 'package:music_playlist/features/core/error/exception.dart';
import 'package:music_playlist/features/core/error/failure.dart';

Failure handleCatchFailure(Object error) {
  switch (error) {
    case ServerException():
      return ServerFailure();
    case TimeoutException():
      return TimeoutFailure();
    case DataNotFoundException():
      return DataNotFoundFailure();
    case UnauthorizedException():
      return InvalidCredentialsFailure();
    case UnexpectedException():
      return UnknownFailure();
    case ForbiddenException():
      return ServerFailure();
    case BadRequestException():
      return ServerFailure();
    default:
      return UnknownFailure();
  }
}
