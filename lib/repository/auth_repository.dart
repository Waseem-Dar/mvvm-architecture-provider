import 'package:mvvm_provider/data/network/base_api_services.dart';
import 'package:mvvm_provider/data/network/network_api_services.dart';
import 'package:mvvm_provider/res/appurls.dart';

class AuthRepository{
final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> signIn(dynamic data)async{
    try{
      final response = await _apiServices.getPostApiResponse(AppUrl.loginApiEndpoint, data);
      return response;
    }catch(e){
      rethrow;
    }

  }


Future<dynamic> signUp(dynamic data)async{
  try{
    final response = await _apiServices.getPostApiResponse(AppUrl.registerApiEndpoint, data);
    return response;
  }catch(e){
    rethrow;
  }

}


}