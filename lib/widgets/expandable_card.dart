import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpandableCardContainer extends StatefulWidget {
  final bool isExpanded;
  final Widget collapsedChild;
  final Widget expandedChild;

  const ExpandableCardContainer(
      {Key? key,
      required this.isExpanded,
      required this.expandedChild,
      required this.collapsedChild})
      : super(key: key);

  @override
  State<ExpandableCardContainer> createState() =>
      _ExpandableCardContainerState();
}

class _ExpandableCardContainerState extends State<ExpandableCardContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      firstChild: widget.collapsedChild,
      secondChild: widget.expandedChild,
      crossFadeState: widget.isExpanded
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
    );
  }
}
