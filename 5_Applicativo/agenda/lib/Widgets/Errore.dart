import 'package:flutter/material.dart';

Widget mostraErrori(List<String> errori) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (String errore in errori)
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            errore,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 11,
            ),
          ),
        ),
    ],
  );
}