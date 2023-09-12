import '../../models/users_model.dart';

abstract class UsersEvent {}

class AddUsersEvent extends UsersEvent {
  Users user;
  AddUsersEvent({required this.user});
}

class AuthenticateUserEvent extends UsersEvent {
  String email;
  String password;
  AuthenticateUserEvent({required this.email, required this.password});
}
