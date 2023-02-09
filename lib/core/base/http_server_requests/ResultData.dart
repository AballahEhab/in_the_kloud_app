class ResultData<T> {
  ResultData._();

  factory ResultData.success(T data) = Success;
  factory ResultData.error(T errorMessage) = Error;
}

class Error<T> extends ResultData<T> {
  Error(this.msg): super._();

  final T msg;
}

class Success<T> extends ResultData<T> {
  Success(this.data): super._();

  final T data;
}