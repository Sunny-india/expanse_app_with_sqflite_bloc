class Expanse {
  int? id;
  int amount, userId;
  String time;
  Expanse(
      {this.id,
      required this.amount,
      required this.time,
      required this.userId});

  factory Expanse.fromExpanseTable(Map<String, dynamic> expanseTable) {
    return Expanse(
        id: expanseTable['id'],
        amount: expanseTable['amount'],
        time: expanseTable['time'],
        userId: expanseTable['userId']);
  }

  Map<String, dynamic> toExpanseTable() {
    return {'id': id, 'amount': amount, 'time': time, 'userId': userId};
  }
}
