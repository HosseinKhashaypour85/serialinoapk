// import 'package:dio/dio.dart';
// import 'package:onlinemovieplatform/features/details_features/services/details_api_services.dart';
//
// class DetailsRepositoryServices {
//   final DetailsApiServices _apiServices = DetailsApiServices();
//
//   Future<List<dynamic>> callDetailsApi(String category) async {
//     try {
//       final Response response = await _apiServices.callDetailsApi(category);
//
//       if (response.statusCode == 200 && response.data != null) {
//         if (response.data is Map && response.data.containsKey('items')) {
//           return response.data['items'] as List<dynamic>;
//         } else {
//           throw Exception('Unexpected response structure: ${response.data}');
//         }
//       } else {
//         throw Exception('Failed to fetch movies. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching movie details: $e');
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:onlinemovieplatform/features/details_features/model/details_model.dart';
import 'package:onlinemovieplatform/features/details_features/services/details_api_services.dart';

class DetailsRepositoryServices {
  final DetailsApiServices _apiServices = DetailsApiServices();
  Future<DetailsModel>callDetailsApi(String category )async{
      final Response response = await _apiServices.callDetailsApi(category);
      DetailsModel detailsModel = DetailsModel.fromJson(response.data);
      return detailsModel;
  }

}
