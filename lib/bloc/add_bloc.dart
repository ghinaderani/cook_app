import 'package:bloc/bloc.dart';
import 'package:cook/model/model.dart';
import 'package:cook/service/service_post.dart';
import 'package:meta/meta.dart';
part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc() : super(AddInitial()) {
    on<Postbloc>((event, emit) async {
      try {
        emit(Loading());
dynamic temp = await  AuthServicePost().postrecipes(event.cooked);
        
        if (temp is String) {
          emit(Error());
          print(temp);
        } else {
          emit(Success());
        }
      } catch (e) {
        emit(Offline());
      }
    });
  }
}
