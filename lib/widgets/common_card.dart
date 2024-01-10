import 'package:flutter/material.dart';

class CommonCard extends StatelessWidget {
  const CommonCard({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
    this.color,
  });

  final Icon icon;
  final String text;
  final Function()? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 150,
          width: 150,
          child: Card(
            color: color,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
