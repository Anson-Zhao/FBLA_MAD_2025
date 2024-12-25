import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress; // Progress value (0.0 to 1.0)
  final String timerText; // Timer text

  const CustomProgressBar({
    super.key,
    required this.progress,
    required this.timerText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390, // Fixed width
      height: MediaQuery.sizeOf(context).height * 0.038, // Dynamic height
      decoration: BoxDecoration(
        color: const Color(0xFF263238), // Background color
        borderRadius: BorderRadius.circular(70), // Rounded corners
      ),
      child: Stack(
        children: [
          // ClipRRect ensures the progress bar stays within the container
          ClipRRect(
            borderRadius: BorderRadius.circular(70), // Same rounded corners
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 390 * progress.clamp(0.0, 1.0), // Clamp progress between 0.0 and 1.0
                height: double.infinity, // Match the height of the container
                decoration: BoxDecoration(
                  color: const Color(0xFF9BA1FF), // Progress color
                  borderRadius: BorderRadius.circular(70), // Rounded corners for the progress line
                ),
              ),
            ),
          ),
          // Timer Text
          Align(
            alignment: AlignmentDirectional(-1, 0), // Align to the left
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
              child: Text(
                timerText, // Timer text (e.g., "00:23")
                style: const TextStyle(
                  fontFamily: 'Prompt',
                  color: Colors.white, // Text color
                  fontSize: 16,
                  letterSpacing: 0.0,
                ),
              ),
            ),
          ),
          // Timer Icon
          const Align(
            alignment: AlignmentDirectional(1, 0), // Align to the right
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
              child: Icon(
                Icons.timer_sharp,
                color: Colors.white, // Icon color matches progress
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
