import 'package:flutter/material.dart';
import 'package:toeic_words_practice/screens/challenge_screen.dart';
import 'package:toeic_words_practice/screens/practice_screen.dart';
import 'package:toeic_words_practice/screens/word_list_screen.dart';

class Chapter extends StatelessWidget {
  final String title;
  final int selectedMode;

  const Chapter({
    super.key,
    required this.title,
    required this.selectedMode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (selectedMode == 0) {
                return PracticeScreen(
                  title: title,
                );
              } else if (selectedMode == 1) {
                return ChallengeScreen(
                  title: title,
                );
              }
              return WordListScreen(
                title: title,
              );
            },
          ),
        );
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 40,
              right: 40,
              top: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green.shade300,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
