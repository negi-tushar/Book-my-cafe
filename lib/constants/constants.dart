import 'package:flutter/material.dart';

const String apiKey = 'AIzaSyCQZcvFWNikgyhWLylgdrm6d4FCTokAs8Q';

const kFormTextColor = TextStyle(
  color: Colors.black,
  fontSize: 14,
);

const kHeading = TextStyle(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.w900,
);
const kLabel = TextStyle(
  color: Colors.black,
  fontSize: 10,
);
SizedBox kHeightSpacer(double value) {
  return SizedBox(
    height: value,
  );
}

SizedBox kWidthSpacer(double value) {
  return SizedBox(
    width: value,
  );
}

const List images = [
  'https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
  'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
  'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'
];
