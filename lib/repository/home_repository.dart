import 'package:mvvm_provider/model/movies_model.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../res/appurls.dart';

class HomeRepository{
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<MoviesListModel> fetchMoviesLIst() async {
    try {
      var response =
      await _apiServices.getGetApiResponse(AppUrl.moviesApiEndpoint);
      return response = MoviesListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}