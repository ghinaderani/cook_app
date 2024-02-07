import 'package:bloc/bloc.dart';
import 'package:cook/config/config.dart';
import 'package:cook/model/model.dart';
import 'package:cook/service/service.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cook_event.dart';
part 'cook_state.dart';

class CookBloc extends Bloc<CookEvent, CookState> {
  CookBloc() : super(CookInitial()) {
    on<GetRecipes>((event, emit) async {
      // try {

      emit(Loading());

      dynamic temp = await RecipesServiecImp().getrecipes();

      if (temp is String) {
        emit(Error());
        print(temp);
      } else {
        List<CookModel> cooking = List.generate(
            temp.length, (index) => CookModel.fromMap(temp[index]));

            config.get<SharedPreferences>().setString('data',cooking[0].toJson());
        emit(Success(cooking: cooking,));
        print(cooking);
      }
      // } catch (e) {
        // emit(Offline());
      // }
    });
  }
}
