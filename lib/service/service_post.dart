import 'package:cook/model/Update_model.dart';
import 'package:cook/model/model.dart';
import 'package:dio/dio.dart';

abstract class AddServiec {
  Dio dio = Dio();
  String baseURL = 'https://656b81d6dac3630cf7282cda.mockapi.io/come/recipe';

  postrecipes(CookModel cooked);
}

class AuthServicePost extends AddServiec {
  @override
  postrecipes(CookModel cooked) async {
    try {
      print(cooked.toJson());
      Response response = await dio.post(baseURL, data: cooked.toJson());
      if (response.statusCode == 201) {
        print(response.data);
        return true;
      } else {
        return 'false';
      }
    } catch (e) {
      print('object');
      throw e;
    }
  }
}

abstract class UpdateServiec {
  Dio dio = Dio();
  String baseURL = 'https://656b81d6dac3630cf7282cda.mockapi.io/come/recipe';
// int id=0;
  updateecipes(UpdateModel edite,String id);
}

class AuthServiceUpdate extends UpdateServiec {
  @override
  updateecipes(UpdateModel edite , String id ) async {
    // try {
      print(edite.toJson());
      Response response = await dio.put('https://656b81d6dac3630cf7282cda.mockapi.io/come/recipe/$id', data: edite.toJson());
      if (response.statusCode == 200) {
        print(response.data);
        return true;
      } else {
        return 'false';
      }
    // } catch (e) {
      // print('object');
      // throw e;
    // }
  }
}


