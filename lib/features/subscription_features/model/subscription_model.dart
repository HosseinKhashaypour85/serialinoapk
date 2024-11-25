import 'package:hive/hive.dart';

part 'subscription_model.g.dart';

@HiveType(typeId: 1)
class SubscriptionModel extends HiveObject {
  @HiveField(0)
  late bool isSubscribed;

  @HiveField(1)
  late DateTime expirationDate;

  SubscriptionModel({
    required this.isSubscribed,
    required this.expirationDate,
  });
}
