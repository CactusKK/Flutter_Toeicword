class WordChapterModel {
  final String word, mean;

  WordChapterModel.fromJson(Map<String, dynamic> json)
      : word = json['word'],
        mean = json['mean'];
}
