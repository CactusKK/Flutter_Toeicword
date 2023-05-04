import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toeic_words_practice/models/word_chapter_model.dart';
import 'package:toeic_words_practice/services/find_json.dart';
import 'package:toeic_words_practice/widgets/challenge_answer_button.dart';

class ChallengeScreen extends StatefulWidget {
  final String title;

  const ChallengeScreen({
    super.key,
    required this.title,
  });

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  late List<WordChapterModel> pairs;
  final Color btnNomarlColor = Colors.lightGreen;
  final Color btnWrongColor = Colors.red;
  final Color btnRightColor = Colors.blue;
  int index = 0;
  bool clickedButton = false;
  String wordText = 'empty_word';
  String rightMean = 'empty_mean';
  List<String> btnMean = ['Button1', 'Button2', 'Button3'];
  List<Color> btnColor = [
    Colors.lightGreen,
    Colors.lightGreen,
    Colors.lightGreen
  ];

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
              height: 50,
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    onTapButton(btnMean[0], 0);
                  },
                  child: ChallengeAnswerButton(
                    mean: btnMean[0],
                    buttonColor: btnColor[0],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    onTapButton(btnMean[1], 1);
                  },
                  child: ChallengeAnswerButton(
                    mean: btnMean[1],
                    buttonColor: btnColor[1],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    onTapButton(btnMean[2], 2);
                  },
                  child: ChallengeAnswerButton(
                    mean: btnMean[2],
                    buttonColor: btnColor[2],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onTapButton(String answerMean, int buttonNo) {
    setState(() {
      if (!clickedButton) {
        clickedButton = true;
        if (answerMean == rightMean) {
          btnColor[buttonNo] = btnRightColor;
        } else {
          btnColor[buttonNo] = btnWrongColor;
        }
        Future.delayed(const Duration(milliseconds: 1500), () {
          setState(() {
            btnColor[buttonNo] = btnNomarlColor;
            clickedButton = false;
            settingNextWord();
          });
        });
      }
    });
  }

  void settingNextWord() {
    final int nextindex = Random().nextInt(pairs.length);
    setState(() {
      wordText = pairs[nextindex].word;
      rightMean = pairs[nextindex].mean;

      for (int i = 0; i < 3; i++) {
        btnMean[i] = pairs[Random().nextInt(pairs.length)].mean;
      }

      btnMean[Random().nextInt(3)] = rightMean;
    });
  }

  Future<void> futureToList() async {
    Future<List<WordChapterModel>> pairsF = FindJson.getPairs(widget.title);
    pairs = await pairsF;
    settingNextWord();
  }
}
