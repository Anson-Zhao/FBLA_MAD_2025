import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerButton({
    super.key,
    required this.answer,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0), // Adjusted vertical padding
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Adjusted padding
          decoration: BoxDecoration(
            color: const Color(0xFF263238), // Fill color stays the same
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 4),
                blurRadius: 8.0,
              ),
            ],
            borderRadius: BorderRadius.circular(20.0), // Slightly smaller radius
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF9BA1FF) // Border color for selected
                  : Colors.white.withOpacity(0.25), // Default border color
              width: 2.0,
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: const TextStyle(
                color: Colors.white, // Text color remains white
                fontSize: 14.0, // Font size
                fontWeight: FontWeight.w500, // Medium weight
              ),
            ),
          ),
        ),
      ),
    );
  }
}
