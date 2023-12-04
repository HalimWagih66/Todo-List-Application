import 'package:flutter/material.dart';

class CustomLine extends StatelessWidget {
  const CustomLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          SizedBox(
            height: 10,
            width: MediaQuery.of(context).size.width * 0.40,
            child: const Divider(
              thickness: 2,
              height: 2,
              endIndent: 5,
              color: Colors.grey,
            ),
          ),
          const Text("OR"),
          SizedBox(
            height: 10,
            width: MediaQuery.of(context).size.width * 0.40,
            child: const Divider(
              thickness: 2,
              height: 2,
              indent:5,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
