import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
//import 'package:go_router/go_router.dart';
import 'package:safebee/data/em_workflow.dart';
import 'package:safebee/styles.dart';

class FrostyBackground extends StatelessWidget {
  const FrostyBackground({
    this.color,
    this.intensity = 25,
    this.child,
    super.key,
  });

  final Color? color;
  final double intensity;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: intensity, sigmaY: intensity),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// A Card-like Widget that responds to tap events by animating changes to its
/// elevation and invoking an optional [onPressed] callback.
class PressableCard extends StatefulWidget {
  const PressableCard({
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.upElevation = 2,
    this.downElevation = 0,
    this.shadowColor = CupertinoColors.black,
    this.duration = const Duration(milliseconds: 100),
    this.onPressed,
    super.key,
  });

  final VoidCallback? onPressed;

  final Widget child;

  final BorderRadius borderRadius;

  final double upElevation;

  final double downElevation;

  final Color shadowColor;

  final Duration duration;

  @override
  State<PressableCard> createState() => _PressableCardState();
}

class _PressableCardState extends State<PressableCard> {
  bool cardIsDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => cardIsDown = false);
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      onTapDown: (details) => setState(() => cardIsDown = true),
      onTapCancel: () => setState(() => cardIsDown = false),
      child: AnimatedPhysicalModel(
        elevation: cardIsDown ? widget.downElevation : widget.upElevation,
        borderRadius: widget.borderRadius,
        shape: BoxShape.rectangle,
        shadowColor: widget.shadowColor,
        duration: widget.duration,
        color: CupertinoColors.lightBackgroundGray,
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: widget.child,
        ),
      ),
    );
  }
}

class EmergencyWorkflowCard extends StatelessWidget {
  const EmergencyWorkflowCard(this.em_workflow, {super.key});

  /// Workflow to be displayed by the card.
  final EmergencyWorkflow em_workflow;

  Widget _buildDetails(BuildContext context) {
    final themeData = CupertinoTheme.of(context);
    return FrostyBackground(
      color: const Color(0x90ffffff),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              em_workflow.name,
              style: Styles.cardTitleText(themeData),
            ),
            Text(
              em_workflow.name,
              style: Styles.cardDescriptionText(themeData),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      onPressed: () {
        // GoRouter does not support relative routes,
        // so navigate to the absolute route.
        // see https://github.com/flutter/flutter/issues/108177
        //context.go('/list/details/${veggie.id}');
      },
      child: Stack(
        children: [
          Semantics(
            label: 'A card background featuring ${em_workflow.name}',
            child: Container(
              height: 300,
              decoration: null,
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildDetails(context),
          ),
        ],
      ),
    );
  }
}
