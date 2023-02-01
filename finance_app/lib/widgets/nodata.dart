import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contraints) {
      return Column(
        children: [
          Container(
            height: contraints.maxHeight * 0.05,
            child: const Text(
              'Одоогоор мэдээлэл байхгүй',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: contraints.maxHeight * 0.01,
          ),
          Container(
            height: contraints.maxHeight * 0.5,
            child: Image.asset('assets/images/folder.png', fit: BoxFit.cover),
          ),
        ],
      );
    });
  }
}
