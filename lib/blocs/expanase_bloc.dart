import 'package:expanse_app_with_sqflite_bloc/blocs/expanse_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database_helper.dart';
import '../models/expanse_model.dart';
import 'expanse_event.dart';

class ExpanseBloc extends Bloc<ExpanseEvent, ExpanseState> {
  SQLHelper db;
  ExpanseBloc({required this.db}) : super(ExpanseInitialState()) {
    on<AddExpanseEvent>((event, emit) async {
      emit(ExpanseLoadingState());
      await db.addExpanse(event.expanse);
      // get uid from shared preferences here, for use
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? uid = prefs.getInt('uid');
      // done
      List<Expanse> innerExp = await db.fetchUserBasedAllExpanses(uid!);
      if (innerExp.isNotEmpty) {
        emit(ExpanseLoadedState(listOfExp: innerExp));
      } else {
        emit(ExpanseErrorState(errorMessage: 'Expanse Not added'));
      }
    });
  }
}
