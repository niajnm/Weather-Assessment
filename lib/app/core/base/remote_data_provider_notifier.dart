import 'package:flutter_riverpod/flutter_riverpod.dart';


// enum DataState { loading, success, error }

// class RemoteDataProviderNotifier extends StateNotifier<DataState> {
//   RemoteDataProviderNotifier() : super(const DataState());

//   DataState _state = DataState.loading;

//   DataState get state => _state;

//   void setState(DataState newState) {
//     _state = newState;
//   }

//   void callDataService() async {
//     try {
//       // Simulating an asynchronous operation
//       await Future.delayed(Duration(seconds: 2));

//       // Mark the state as success
//       setState(DataState.success);
//     } catch (error) {
//       // Mark the state as error and handle the error
//       setState(DataState.error);
//       print("Error: $error");
//     }
//   }
// }
