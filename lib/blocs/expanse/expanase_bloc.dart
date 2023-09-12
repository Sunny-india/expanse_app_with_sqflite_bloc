import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database_helper.dart';
import '../../models/expanse_model.dart';
import 'expanse_event.dart';
import 'expanse_state.dart';

class ExpanseBloc extends Bloc<ExpanseEvent, ExpanseState> {
  SQLHelper db;
  ExpanseBloc({required this.db}) : super(ExpanseInitialState()) {
    /// when you add expanses
    on<AddExpanseEvent>((event, emit) async {
      emit(ExpanseLoadingState());
      bool check = await db.addExpanse(event.expanse);
      if (check) {
        List<Expanse> innerExp = await db.fetchAllExpanses();
        emit(ExpanseLoadedState(listOfExp: innerExp));
      } else {
        emit(ExpanseErrorState(errorMessage: 'Expanse Not Added..!'));
      }
    });

    /// to fetch all expanses based on individual user,
    on<FetchAllExpanseEvent>((event, emit) async {
      emit(ExpanseLoadingState());
      //todo: to fetch expanse based on UserId
      //await db.fetchUserBasedAllExpanses(uid);
      List<Expanse> allExp = await db.fetchAllExpanses();
      if (allExp.isNotEmpty) {
        emit(ExpanseLoadedState(listOfExp: allExp));
      } else {
        emit(ExpanseErrorState(
            errorMessage: 'Could not fetch through bloc-state'));
      }
    });
  }
}
