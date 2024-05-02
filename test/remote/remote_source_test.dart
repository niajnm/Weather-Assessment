// import 'dart:io';

// import 'package:dio/dio.dart';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flutter_assessment/app/utils/constants.dart';
// import 'package:logger/logger.dart';

// import '../../lib/flavors/build_config.dart';
// import '../../lib/flavors/env_config.dart';
// import '../../lib/flavors/environment.dart';
// import 'remote_source_test.mocks.dart';

// @GenerateMocks([Dio])
// void main() {
//   // Call the setup function before running tests
//   setUp(() {
//     setupBuildConfigForTesting();
//   });
//   MockDio dio = MockDio();

//   GitHubRepositoryRemoteSourceImpl remoteDataSource =
//       GitHubRepositoryRemoteSourceImpl();

//   group('fetchRepositoryList', () {
//     final params = GitHubRepositoryParams(sortBy: "stars", pageNo: 1);

//     test('returns an RepositoryList if the http call completes successfully',
//         () async {
//       final responseData = {
//         "items": [
//           {
//             "id": 425832081,
//             "name": "FlutterWorkshop",
//             "full_name": "hasnain40247/FlutterWorkshop",
//             "owner": {
//               "login": "hasnain40247",
//               "avatar_url":
//                   "https://avatars.githubusercontent.com/u/52504037?v=4"
//             },
//             "updated_at": "2021-11-11T11:42:31Z",
//             "language": "Dart"
//           }
//         ]
//       };

//       final fakeResponse = Response(
//         data: responseData,
//         requestOptions: RequestOptions(),
//       );

//       // Use Mockito to return fake response when Dio's get() is called
//       when(dio.get('https://api.github.com/search/repositories',
//               queryParameters: anyNamed('queryParameters')))
//           .thenAnswer((_) async => fakeResponse);

//       // Call the method under test
//       final result = await remoteDataSource.getRepositoryList(params);

//       // Verify result
//       expect(result, isA<RemoteGitHubRepositoryResponse>());
//       expect(result.items!.length, equals(10));
//     });
//   });
// }

// void setupBuildConfigForTesting() {
//   // Initialize BuildConfig with test configurations
//   EnvConfig testConfig = EnvConfig(
//     appName: "Your Test App",
//     baseUrl: "https://api.github.com/",
//     shouldCollectCrashLog: false,
//   );

//   Logger(
//     printer: PrettyPrinter(
//         methodCount: loggerMethodCount,
//         // number of method calls to be displayed
//         errorMethodCount: loggerErrorMethodCount,
//         // number of method calls if stacktrace is provided
//         lineLength: loggerLineLength,
//         // width of the output
//         colors: true,
//         // Colorful log messages
//         printEmojis: true,
//         // Print an emoji for each log message
//         printTime: false // Should each log print contain a timestamp
//         ),
//   );

//   BuildConfig.instantiate(
//     envType: Environment.PRODUCTION,
//     envConfig: testConfig,
//   );
// }
