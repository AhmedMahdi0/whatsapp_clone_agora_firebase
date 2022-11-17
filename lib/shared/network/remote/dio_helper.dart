// import 'package:dio/dio.dart';
//
// class DioHelper {
//   static Dio dio = Dio();
//   final String apiKey = 'api_key=3077773f2719a5a1897efbe52a97bab4';
//
//
//   static Future<Response> gatData({required String url,String? sea}) async {
//     // try {
//     final String st;
//     if(sea == null){
//       st =
//           'http://api.themoviedb.org/3${url}api_key=3077773f2719a5a1897efbe52a97bab4';}
//     else {
//       st =
//           'http://api.themoviedb.org/3${url}api_key=3077773f2719a5a1897efbe52a97bab4$sea';
//     }
//       return await dio.get(st);
//   }
// }
