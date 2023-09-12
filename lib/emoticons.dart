import 'package:flutter/material.dart';

class Emoticon extends StatelessWidget {

  final String emoticon;

  const Emoticon({
    super.key,
    required this.emoticon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue[600],
          borderRadius: BorderRadius.circular(14)
      ),
      padding: EdgeInsets.all(16),
      child: Center(child: Text(
          emoticon,
            style: TextStyle(
                fontSize: 30
            ),
        ),
      ),
    );
  }
}
