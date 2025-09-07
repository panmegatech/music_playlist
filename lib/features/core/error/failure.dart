abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure([super.message = "Server Failure"]);
}

class NetworkFailure extends Failure {
  NetworkFailure([super.message = "Network Failure"]);
}

class CacheFailure extends Failure {
  CacheFailure([super.message = "Cache Failure"]);
}

class InvalidCredentialsFailure extends Failure {
  InvalidCredentialsFailure([super.message = "Invalid username or password"]);
}

class UserNotFoundFailure extends Failure {
  UserNotFoundFailure([super.message = "User not found"]);
}

class DataNotFoundFailure extends Failure {
  DataNotFoundFailure([super.message = "Data not found"]);
}

class AccountLockedFailure extends Failure {
  AccountLockedFailure([super.message = "Your account has been locked"]);
}

class TooManyRequestsFailure extends Failure {
  TooManyRequestsFailure(
      [super.message = "Too many login attempts. Try again later"]);
}

class TokenExpiredFailure extends Failure {
  TokenExpiredFailure([super.message = "Session expired. Please login again"]);
}

class UnknownFailure extends Failure {
  UnknownFailure([super.message = "An unknown error occurred"]);
}

class TimeoutFailure extends Failure {
  TimeoutFailure([super.message = "Request timed out. Please try again"]);
}
