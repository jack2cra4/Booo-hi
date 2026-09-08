import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../theme/app_theme.dart';

class ConfettiCelebration extends StatefulWidget {
  final Widget child;
  final bool active;

  const ConfettiCelebration({
    super.key,
    required this.child,
    this.active = false,
  });

  @override
  State<ConfettiCelebration> createState() => _ConfettiCelebrationState();
}

class _ConfettiCelebrationState extends State<ConfettiCelebration>
    with TickerProviderStateMixin {
  late final ConfettiController _controller = ConfettiController(
    duration: const Duration(seconds: 3),
  );

  @override
  void initState() {
    super.initState();
    if (widget.active) {
      _controller.play();
    }
  }

  @override
  void didUpdateWidget(covariant ConfettiCelebration oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active) {
      _controller.play();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        widget.child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ConfettiWidget(
            confettiController: _controller,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 40,
            colors: const [
              AppTheme.primary,
              AppTheme.secondary,
              AppTheme.accent,
              AppTheme.warning,
              AppTheme.star,
            ],
            gravity: 0.3,
            emissionFrequency: 0.01,
            particleDrag: 0.05,
          ),
        ),
      ],
    );
  }
}

class StarRating extends StatelessWidget {
  final int stars;
  final double size;

  const StarRating({
    super.key,
    required this.stars,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(
            i < stars ? Icons.star : Icons.star_border,
            color: AppTheme.star,
            size: size,
          ),
        );
      }),
    );
  }
}

class LessonCompletionDialog extends StatelessWidget {
  final int stars;
  final String message;
  final VoidCallback onContinue;

  const LessonCompletionDialog({
    super.key,
    required this.stars,
    required this.message,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.celebration, size: 64, color: AppTheme.warning),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            StarRating(stars: stars),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onContinue,
              child: const Text('जारी रखें / Continue'),
            ),
          ],
        ),
      ),
    );
  }
}