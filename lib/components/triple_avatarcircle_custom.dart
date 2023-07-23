import 'package:flutter/material.dart';

class TripleAvatarCircleCustom extends StatelessWidget {
  const TripleAvatarCircleCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          widthFactor: 0.5,
          child: CircleAvatar(
            backgroundColor: Colors.yellow,
            radius: 15,
            child: Icon(Icons.abc, size: 15),
          ),
        ),
        Align(
          widthFactor: 0.5,
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 15,
            child: Icon(Icons.abc, size: 15),
          ),
        ),
        Align(
          widthFactor: 0.5,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 15,
            child: Icon(Icons.abc, size: 15),
          ),
        ),
        Align(
          widthFactor: 0.5,
          child: CircleAvatar(
            radius: 15,
            child: Icon(Icons.add, size: 15),
          ),
        ),
      ],
    );
  }
}
