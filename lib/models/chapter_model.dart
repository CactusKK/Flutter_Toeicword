class ChapterModel {
  final String title;

  ChapterModel.fromJson(Map<String, dynamic> json) : title = json['title'];
}
