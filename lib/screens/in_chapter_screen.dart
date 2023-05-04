import 'package:flutter/material.dart';
import 'package:toeic_words_practice/models/word_chapter_model.dart';
import 'package:toeic_words_practice/services/find_json.dart';

class InChapterScreen extends StatefulWidget {
  final String title;

  const InChapterScreen({
    super.key,
    required this.title,
  });

  @override
  State<InChapterScreen> createState() => _InChapterScreenState();
}

class _InChapterScreenState extends State<InChapterScreen> {
  late List<WordChapterModel> pairs;
  int index = 0;
  String wordText = 'empty_word';
  String meanText = 'empty_mean';
  bool answerOpen = false;

  @override
  void initState() {
    super.initState();
    futureToList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: Colors.purple,
                  width: 2,
                ),
                color: Colors.purple.withOpacity(0.3),
              ),
              child: Center(
                child: Text(
                  wordText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: Colors.purple,
                  width: 2,
                ),
                color: Colors.purple.withOpacity(0.3),
              ),
              child: Center(
                child: Text(
                  meanText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 65,
            ),
            TextButton(
              onPressed: onTapButton,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 25,
                  ),
                  child: Text(
                    "Button",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapButton() {
    setState(() {
      if (answerOpen) {
        //next pair
        if (index < pairs.length) {
          index++;
        } else {
          index = 0;
        }
        wordText = pairs[index].word;
        meanText = "_ _ _ _";
      } else {
        //open meanText
        meanText = pairs[index].mean;
      }

      answerOpen = !answerOpen;
    });
  }

  Future<void> futureToList() async {
    Future<List<WordChapterModel>> pairsF = FindJson.getPairs(widget.title);
    pairs = await pairsF;
    setState(() {
      wordText = pairs[index].word;
      meanText = "_ _ _ _";
    });
  }
}
