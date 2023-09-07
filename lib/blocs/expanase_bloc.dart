import 'package:expanse_app_with_sqflite_bloc/blocs/expanse_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database_helper.dart';
import '../models/expanse_model.dart';
import 'expanse_event.dart';

class ExpanseBloc extends Bloc<ExpanseEvent, ExpanseState> {
  SQLHelper db;
  ExpanseBloc({required this.db}) : super(ExpanseInitialState()) {
    /// when you add expanses
    on<AddExpanseEvent>((event, emit) async {
      emit(ExpanseLoadingState());
      await db.addExpanse(event.expanse);

      List<Expanse> innerExp = await db.fetchAllExpanses();

      if (innerExp.isNotEmpty) {
        emit(ExpanseLoadedState(listOfExp: innerExp));
      } else {
        emit(ExpanseErrorState(errorMessage: 'Expanse Not added'));
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
