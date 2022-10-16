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
//
// sealed class Result<T>(
// val data: T? = null,
// val error: String? = null
// ) {
// private val TAG = "class Result<T>"
// class Success<T>(data: T) : Result<T>(data = data)
// class Loading<T>(data: T? = null) : Result<T>(data = data)
// class Error<T>(error: String, data: T? = null) : Result<T>(data = data, error =  error)
// fun handleRepoResponse(
// onPreExecute:()->Unit = { },
// onLoading:  () -> Unit = { },
// onError:  () -> Unit,
// onSuccess:  () -> Unit){
//
// onPreExecute()
//
// when(this)
// {
// is Loading->onLoading()
// is Error -> {
// NadrisApplication.instance?.connectivityMonitor?.checkConnectivity() ?: Log.v(TAG,"couldn't check connectivity null")
// onError()
// }
// is Success -> onSuccess()
// }
// }
// }
