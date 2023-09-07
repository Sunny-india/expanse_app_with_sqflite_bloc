import '../models/expanse_model.dart';

abstract class ExpanseEvent {}

class AddExpanseEvent extends ExpanseEvent {
  Expanse expanse;
  AddExpanseEvent({required this.expanse});
}

/// fetch on the basis of user id
class FetchAllExpanseEvent extends ExpanseEvent {}
