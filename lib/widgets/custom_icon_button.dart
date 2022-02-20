import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  final String title;
  const CustomIconButton({
    Key? key,
    required this.image,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: CircleAvatar(
                  backgroundColor: Colors.pink.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
