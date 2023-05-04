import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:toeic_words_practice/models/chapter_model.dart';
import 'package:toeic_words_practice/models/word_chapter_model.dart';

class FindJson {
  static Future<List<ChapterModel>> getChapter() async {
    List<ChapterModel> chapters = [];
    String jsonString =
        await rootBundle.loadString('assets/json/chapterList.json');

    List<dynamic> chapterNos = json.decode(jsonString);

    for (var chapter in chapterNos) {
      chapters.add(ChapterModel.fromJson(chapter));
    }

    return chapters;
  }

  static Future<List<WordChapterModel>> getPairs(String title) async {
    List<WordChapterModel> pairs = [];
    String jsonString = await rootBundle.loadString('assets/json/$title.json');

    List<dynamic> wordchaptermodels = json.decode(jsonString);

    for (var wordchaptermodel in wordchaptermodels) {
      pairs.add(WordChapterModel.fromJson(wordchaptermodel));
    }

    return pairs;
  }
}
