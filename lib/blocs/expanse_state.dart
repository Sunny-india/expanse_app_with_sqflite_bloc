import '../models/expanse_model.dart';

abstract class ExpanseState {}

class ExpanseInitialState extends ExpanseState {}

class ExpanseLoadingState extends ExpanseState {}

class ExpanseLoadedState extends ExpanseState {
  List<Expanse> listOfExp;
  ExpanseLoadedState({required this.listOfExp});
}

class ExpanseErrorState extends ExpanseState {
  String errorMessage;
  ExpanseErrorState({required this.errorMessage});
}
