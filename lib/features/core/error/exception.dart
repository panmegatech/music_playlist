class ServerException implements Exception {
  final String message;

  ServerException([this.message = "Server error occurred."]);
}

class DataNotFoundException implements Exception {
  final String message;

  DataNotFoundException([this.message = "Data not found"]);
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = "Network error occurred."]);
}

class UnexpectedException implements Exception {
  final String message;

  UnexpectedException([this.message = "Unexpected error"]);
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException([this.message = "Unauthorized"]);
}

class InvalidCredentialsException implements Exception {
  final String message;

  InvalidCredentialsException([this.message = "Invalid username or password"]);

  @override
  String toString() => "InvalidCredentialsException: $message";
}

class ForbiddenException implements Exception {
  final String message;

  ForbiddenException(
      [this.message = "You are not authorized to access this resource"]);
}

class BadRequestException implements Exception {
  final String message;

  BadRequestException([this.message = "Bad Request"]);
}

class SocketException implements Exception {
  final String message;

  SocketException([this.message = "No Internet connection."]);
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);

  @override
  String toString() => 'TimeoutException: $message';
}

class InvalidResponseException implements Exception {
  final String message;
  InvalidResponseException(this.message);

  @override
  String toString() => 'InvalidResponseException: $message';
}
