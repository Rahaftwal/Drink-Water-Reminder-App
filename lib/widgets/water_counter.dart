// Developer Information
// File: water_counter.dart
// Description: Widget for tracking and displaying water intake
// Author: Rahaf AL-Twal
// Date: 2025
// Version: 1.0.0

import 'package:flutter/material.dart';

class WaterCounter extends StatelessWidget {
  final int glassesDrank;
  final VoidCallback onIncrement;
  const WaterCounter({
    super.key,
    required this.glassesDrank,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onIncrement,
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated water drop
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 1.0 + (value * 0.1),
                  child: child,
                );
              },
              // child: const Icon(
              //   Icons.water_drop,
              //   size: 50,
              //   color: Colors.blue,
              // ),
            ),
            // Counter text
            // Positioned(
            //   bottom: 60,
            //   child: Text(
            //     '$glassesDrank',
            //     style: const TextStyle(
            //       fontSize: 40,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.blue,
            //     ),
            //   ),
            // ),
            // Plus button
            Positioned(
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            // Tap hint
            Positioned(
              top: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Text(
                  'Tap to add',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 