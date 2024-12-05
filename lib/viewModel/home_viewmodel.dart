import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_provider/data/response/api_response.dart';
import 'package:mvvm_provider/model/movies_model.dart';
import 'package:mvvm_provider/repository/home_repository.dart';

class HomeViewModel with ChangeNotifier{

  HomeRepository homeRepository = HomeRepository();

  ApiResponse<MoviesListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MoviesListModel> response){
    moviesList = response;
    notifyListeners();
  }

  void fetchMoviesData()async {
    setMoviesList(ApiResponse.loading());
    homeRepository.fetchMoviesLIst().then((value) {
      setMoviesList(ApiResponse.complete(value));
      if (kDebugMode) {
        print("before completed im here!");
      }
    },).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    },);
  }

}