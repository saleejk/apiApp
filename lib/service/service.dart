// import 'dart:convert';
// import 'dart:developer';
// import 'package:dio/dio.dart';

// class RegisterService {
//   Dio dio = Dio();
//   // void createUser(Map<String, dynamic> value) async {
//   //   print(value);
//   //   final url = 'http://socialmedia-api-v1.onrender.com/auth/register';
//   //   try {
//   //     final response =
//   //         await dio.post(url, data: jsonEncode(value), options: Options(
//   //       validateStatus: (status) {
//   //         return status! < 500;
//   //       },
//   //     ));
//   //     print(response.data);
//   //     print(1234567890);
//   //     if (response.statusCode == 201) {
//   //       log('user creation completed');
//   //     } else {
//   //       log('failed to register');
//   //     }
//   //   } catch (e) {
//   //     log('fffffffailed $e');
//   //   }
//   // }

//   Future<void> createUser(
//       String username, String email, String password) async {
//     try {
//       final dio = Dio();
//       final response = await dio.post(
//         'http://socialmedia-api-v1.onrender.com/auth/register',
//         data: {
//           'username': username,
//           'email': email,
//           'password': password,
//         },
//       );
//       if (response.statusCode == 200) {
//         // Registration successful
//         print('Registration successful');
//       } else {
//         // Registration failed
//         print('Registration failed');
//       }
//     } catch (e) {
//       // Handle error
//       print('Error registering account: $e');
//     }
//   }
// }
// import 'dart:developer';
// import 'dart:ffi';

// import 'package:dio/dio.dart';

// class RegisterService {
//   final Dio dio = Dio();
//   Future<void> getToken(String email, String password, String userName) async {
//     try {
//       String apiUrl = 'http://socialmedia-api-v1.onrender.com/auth/register';
//       FormData formData = FormData.fromMap({
//         'email': email,
//         'password': password,
//         'username': userName,
//       });
//       Response response = await dio.post(apiUrl, data: formData);
//       if (response.statusCode == 201) {
//         String token = response.data['token'];
//         log(token);
//       }
//     } catch (e) {
//       print('responce$e');
//     }
//   }
// }
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class RegisterService {
  final Dio dio = Dio();

  Future<String?> getToken(
      String email, String password, String userName) async {
    try {
      log('servicetest');
      Response response = await dio.post(
        'http://socialmedia-api-v1.onrender.com/auth/register',
        data: {
          'email': email,
          'password': password,
          'username': userName,
        },
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      log("---------------------------------------------------");
      print(response.statusCode);
      if (response.statusCode == 307) {
        String? redirectUrl = extractRedirectUrl(response.headers);
        if (redirectUrl != null) {
          return await getTokenAfterRedirect(
              redirectUrl, email, password, userName);
        } else {
          print('Redirect URL not found in response headers');
          return null;
        }
      } else if (response.statusCode == 201) {
        final responseData = json.decode(response.data);
        String token = responseData['token'];
        return token;
      } else {
        print('Registration failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error registering user: $e');
      return null;
    }
  }

  String? extractRedirectUrl(Headers headers) {
    List<String>? locationHeaders = headers.map['location'];
    if (locationHeaders != null && locationHeaders.isNotEmpty) {
      return locationHeaders.first;
    }
    return null;
  }

  Future<String?> getTokenAfterRedirect(String redirectUrl, String email,
      String password, String userName) async {
    try {
      Response response = await dio.post(
        redirectUrl,
        data: {
          'email': email,
          'password': password,
          'username': userName,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        final responseData = json.decode(response.data);
        String token = responseData['token'];
        return token;
      } else if (response.statusCode == 500) {
        print('Error 500');
        return null;
      }
    } catch (e) {
      log('Error registering user after redirection: $e');
      return null;
    }
  }
}
