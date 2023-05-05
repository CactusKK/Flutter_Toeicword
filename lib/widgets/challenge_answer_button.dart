import 'package:flutter/material.dart';

class ChallengeAnswerButton extends StatelessWidget {
  final String mean;
  final Color buttonColor;

  const ChallengeAnswerButton({
    super.key,
    required this.mean,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: buttonColor,
          width: 2,
        ),
        color: buttonColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 25,
        ),
        child: Center(
          child: Text(
            mean,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
