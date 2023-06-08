import 'package:hive_flutter/adapters.dart';
part 'db_model.g.dart';

@HiveType(typeId: 1)
class CameraApp {
  @HiveField(0)
  String? filePath;
}
