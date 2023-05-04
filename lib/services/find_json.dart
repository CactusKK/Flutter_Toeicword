import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:toeic_words_practice/models/chapter_model.dart';

class FindJson {
  static Future<List<ChapterModel>> getChapter() async {
    List<ChapterModel> chapters = [];
    String jsonString =
        await rootBundle.loadString('assets/json/chapterList.json');

    print("M>>$jsonString");

    List<dynamic> chapterNos = json.decode(jsonString);

    for (var chapter in chapterNos) {
      chapters.add(ChapterModel.fromJson(chapter));
      print(">>>$chapter");
    }

    return chapters;
  }
}
