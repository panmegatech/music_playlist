// base class of usecase that return stream / generic (T)
abstract class StreamUseCase<T> {
  Stream<T>? execute();
}
