import 'package:dio/dio.dart';

import '../../constants/strings.dart';

class QuoteWebServices{
  late Dio dio;

  QuoteWebServices(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: 30 * 1000,
      connectTimeout: 30 * 1000,
    );

    dio = Dio(options);
  }
  
  Future<List<dynamic>> getAllQuotes(String charName)async{
    try{
      Response response = await dio.get('quote',queryParameters: {'author': charName});
      return response.data;
    }catch(e){
      print(e.toString());
      return [];
    }
  }
}