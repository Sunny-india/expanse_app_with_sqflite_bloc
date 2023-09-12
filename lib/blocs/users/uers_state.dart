import '../../models/users_model.dart';

abstract class UsersState {}

class UserErrorState extends UsersState {
  String errorMessage;
  UserErrorState({required this.errorMessage});
}

class UserLoadedState extends UsersState {
  List<Users> users;
  UserLoadedState({required this.users});
}

class AuthenticateUserState extends UsersState {
  bool foundOrNot;
  AuthenticateUserState({required this.foundOrNot});
}
