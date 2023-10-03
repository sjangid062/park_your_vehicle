import 'package:flutter/material.dart';

class BuildDisplayLargeText extends StatelessWidget {
  const BuildDisplayLargeText({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,
    style: Theme.of(context).textTheme.displayLarge);
  }
}

class BuildDisplayMediumText extends StatelessWidget {
  const BuildDisplayMediumText({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: Theme.of(context).textTheme.displayMedium);
  }
}

class BuildDisplaySmallText extends StatelessWidget {
  const BuildDisplaySmallText({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: Theme.of(context).textTheme.displaySmall);
  }
}

class BuildBodyLargeText extends StatelessWidget {
  const BuildBodyLargeText({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: Theme.of(context).textTheme.bodyLarge);
  }
}

class BuildBodyMediumText extends StatelessWidget {
  const BuildBodyMediumText({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: Theme.of(context).textTheme.bodyMedium);
  }
}
