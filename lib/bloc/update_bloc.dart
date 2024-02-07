import 'package:bloc/bloc.dart';
import 'package:cook/model/Update_model.dart';
import 'package:cook/model/model.dart';
import 'package:cook/service/service_post.dart';
import 'package:meta/meta.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitial()) {
    on<Upbloc>((event, emit) async {
      // try {
        emit(Loading());
        dynamic temp = await AuthServiceUpdate().updateecipes(event.edite, event.id);

        if (temp is String) {
          emit(Error());
          print(temp);
        } else {
          emit(Success());
        }
      // }
      //  catch (e) {
        // emit(Offline());
      // }
    });
  }
}
