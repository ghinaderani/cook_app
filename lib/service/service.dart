import 'package:dio/dio.dart';

abstract class RecipesServiec {
  Dio dio = Dio();

  String baseUrl = 'https://656b81d6dac3630cf7282cda.mockapi.io/come/recipe';

  getrecipes();
}
class RecipesServiecImp extends RecipesServiec {
 
@override

getrecipes() async {
    // try {
      Response response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        print(response);
        return response.data;
      } else {
        return 'false';
      }
    // } catch (e) {
      // print('object');
      // throw e;
    // }
  }

 }

 