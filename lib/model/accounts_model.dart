import 'package:hive/hive.dart';


part 'accounts_model.g.dart';

@HiveType(typeId: 1)
class AccountsData extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late int totalLoad;

  @HiveField(2)
  late int sendedLoad;

  @HiveField(3)
  late int remainingLoad;

  AccountsData({
    required this.id,
    required this.totalLoad,
    required this.sendedLoad,
    required this.remainingLoad,
  });

  AccountsData copyWith({
    String? id,
    int? totalLoad,
    int? sendedLoad,
    int? remainingLoad,
  }) {
    return AccountsData(
      id: id ?? this.id,
      totalLoad: totalLoad ?? this.totalLoad,
      sendedLoad: sendedLoad ?? this.sendedLoad,
      remainingLoad: remainingLoad ?? this.remainingLoad,
    );
  }
}