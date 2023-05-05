import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toeic_words_practice/models/word_chapter_model.dart';
import 'package:toeic_words_practice/services/find_json.dart';
import 'package:http/http.dart' as http;

const apiKey = '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';
const apiUrl = 'https://api.openai.com/v1/completions';

class PracticeScreen extends StatefulWidget {
  final String title;

  const PracticeScreen({
    super.key,
    required this.title,
  });

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late List<WordChapterModel> pairs;
  int pairLength = 0;
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
        backgroundColor: const Color(0xffF7E1AE),
        foregroundColor: const Color(0xff617A55),
        elevation: 2,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xffFFF8D6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 10,
            ),
            Center(
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
                        color: const Color(0xffA4D0A4),
                        width: 3,
                      ),
                      color: const Color(0xffA4D0A4).withOpacity(0.3),
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
                        color: const Color(0xffA4D0A4),
                        width: 3,
                      ),
                      color: const Color(0xffA4D0A4).withOpacity(0.3),
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
                    height: 55,
                  ),
                  TextButton(
                    onPressed: onTapButton,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff617A55).withOpacity(0.4),
                          width: 3,
                        ),
                        color: const Color(0xff617A55),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 50,
                        ),
                        child: Text(
                          "Button",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: const Offset(0, -2),
                  )
                ],
                color: const Color(0xffF7E1AE),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${index + 1} / $pairLength",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8294C4),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffDBDFEA),
                        ),
                        child: TextButton(
                          onPressed: () {
                            _showDialog(wordText);
                          },
                          child: const Text(
                            "Chat GPT",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
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
      pairLength = pairs.length;
    });
  }

  void _showDialog(String word) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: const Color(0xffDBDFEA),
          title: Text("$word 에 대해 알려줘"),
          content: FutureBuilder(
            future: generateText("영단어 $word에 대해서 설명해 줄래?"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              }
              return const SizedBox(
                height: 130,
                width: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Close",
                style: TextStyle(
                  color: Color(0xff8294C4),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> generateText(String prompt) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode({
        "model": "text-davinci-003",
        'prompt': prompt,
        'max_tokens': 1000,
        'temperature': 0,
        'top_p': 1,
        'frequency_penalty': 0,
        'presence_penalty': 0
      }),
    );

    Map<String, dynamic> newresponse =
        jsonDecode(utf8.decode(response.bodyBytes));

    return newresponse['choices'][0]['text'];
  }
}
