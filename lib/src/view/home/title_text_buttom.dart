import 'package:flutter/material.dart';

class TitleTextButtom extends StatelessWidget {
  const TitleTextButtom({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
            onPressed: onPressed,
            child: const Text(
              "View more",
            ))
      ],
    );
  }
}
