import 'package:flutter/material.dart';

class WordListComponent extends StatelessWidget {
  final String word, mean;

  const WordListComponent({
    super.key,
    required this.word,
    required this.mean,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.lightGreen.withOpacity(0.5),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(3),
        color: Colors.lightGreen.withOpacity(0.8),
      ),
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              word,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            Text(
              mean,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
