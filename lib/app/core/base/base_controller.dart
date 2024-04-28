
// import 'package:flutter_craft/app/core/base/base_state.dart';
// import 'package:flutter_craft/flavors/build_config.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:logger/logger.dart';

// class BaseController<T> extends StateNotifier<BaseState<T>> {
//   BaseController() : super(const LoadingState());

//   final Logger logger = BuildConfig.instance.config.logger;

//   void startLoading() {
//     state = const LoadingState();
//   }

//   void hideLoading() {
//     state = const LoadingState();
//   }

//   void setData(T data) {
//     state = BaseState.data(data);
//   }

//   void showErrorMessage(String errorMessage) {
//     state = BaseState.error(errorMessage);
//   }

//   dynamic callDataService(
//     Future<T> future, {
//     Function(Exception exception)? onError,
//     Function(T response)? onSuccess,
//     Function? onStart,
//     Function? onComplete,
//   }) async {
//     Exception? _exception;

//     onStart == null ? startLoading() : onStart();

//     try {
//       final T response = await future;

//       if (onSuccess != null) onSuccess(response);

//       onComplete == null ? hideLoading() : onComplete();

//       return response;
//     } on ServiceUnavailableException catch (exception) {
//       _exception = exception;
//       showErrorMessage(exception.message);
//     } on UnauthorizedException catch (exception) {
//       _exception = exception;
//       showErrorMessage(exception.message);
//     } on TimeoutException catch (exception) {
//       _exception = exception;
//       showErrorMessage(exception.message ?? 'Timeout exception');
//     } on NetworkException catch (exception) {
//       _exception = exception;
//       showErrorMessage(exception.message);
//     } on JsonFormatException catch (exception) {
//       _exception = exception;
//       showErrorMessage(exception.message);
//     } on NotFoundException catch (exception) {
//       _exception = exception;
//       showErrorMessage(exception.message);
//     } on ApiException catch (exception) {
//       _exception = exception;
//     } on AppException catch (exception) {
//       _exception = exception;
//       showErrorMessage(exception.message);
//     } catch (error) {
//       _exception = AppException(message: "$error");
//       logger.e("Controller>>>>>> error $error");
//     }

//     if (onError != null) onError(_exception);

//     onComplete == null ? hideLoading() : onComplete();
//   }
// }
