import 'package:flutter/material.dart';

class DashDisplay extends StatelessWidget {
  final String display, expression;
  final double titleSz, subSz;
  final FontWeight weight;
  const DashDisplay({super.key, required this.display, required this.expression,
      required this.titleSz, required this.subSz, required this.weight});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      color: cs.surfaceContainerHighest,
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        if (expression.isNotEmpty)
          Text(expression,
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: subSz),
              textAlign: TextAlign.right),
        const SizedBox(height: 8),
        Text(display,
            style: TextStyle(color: cs.onSurface, fontSize: titleSz, fontWeight: weight),
            maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.right),
      ]),
    );
  }
}
