import 'package:flutter/material.dart';

class PlayBtn extends StatelessWidget {
  final bool play;
  final void Function()? onTap;
  const PlayBtn({
    super.key,
    this.play = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.7),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(15.0),
        child: Icon(
          play ? Icons.play_arrow : Icons.stop,
          size: 50.0,
        ),
      ),
    );
  }
}
