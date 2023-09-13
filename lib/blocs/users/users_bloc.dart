import 'package:expanse_app_with_sqflite_bloc/blocs/users/uers_state.dart';
import 'package:expanse_app_with_sqflite_bloc/blocs/users/users_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database_helper.dart';
import '../../models/users_model.dart';

class UserBloc extends Bloc<UsersEvent, UsersState> {
  SQLHelper db;
  UserBloc({required this.db}) : super(UserLoadedState(users: [])) {
    /// for adding user
    on<AddUsersEvent>((event, emit) async {
      bool added = await db.addUser(event.user);
      if (added == true) {
        List<Users> addedUser = await db.fetchUsers();
        emit(UserLoadedState(users: addedUser));
      } else {
        emit(UserErrorState(errorMessage: 'User Not Added'));
      }
    });

    ///===for authentication or login===///
    on<AuthenticateUserEvent>((event, emit) async {
      List<Users> userFoundOrNot = await db.authenticateUser(
          email: event.email, password: event.password);
      if (userFoundOrNot.isNotEmpty) {
        emit(UserLoadedState(users: userFoundOrNot));
      } else {
        emit(
            UserErrorState(errorMessage: 'User carrying this email Not Found'));
      }
    });
  }
}
