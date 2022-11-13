import 'package:dio/dio.dart';

import '../../constants/strings.dart';

class CharactersWebServices{
  late Dio dio;
  CharactersWebServices(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: 30 * 1000,
      connectTimeout: 30 * 1000, //3 seconds
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters()async{
    try{
      Response response = await dio.get('characters');
      return response.data;
    }catch(e){
      print(e.toString());
      return [];
    }
  }
}