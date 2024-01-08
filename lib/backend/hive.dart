import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  addRecord("Deneme Başlığı", "Deneme İçeriği");
}

@HiveType(typeId: 0)
class PostModel extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;
}

Future<Box<PostModel>> addRecord(String title, String content) async {
  final box = await Hive.openBox<PostModel>('posts');

  final post = PostModel()
    ..title = title
    ..content = content;
  await box.add(post);
  return box;
}

List<PostModel> getRecords(final box) {
  final List<PostModel> posts = box.values.ToList();
  return posts;
}
