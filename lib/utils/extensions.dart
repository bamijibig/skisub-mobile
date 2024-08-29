import 'package:flutter/material.dart';

extension ASSET on String {
  String toPNG() {
    return "assets/images/png/$this.png";
  }

  String toSVG() {
    return "assets/images/svg/$this.svg";
  }
}

extension SPACER on num {
  SizedBox get vSpace {
    return SizedBox(
      height: toDouble(),
    );
  }

  SizedBox get hSpace {
    return SizedBox(
      width: toDouble(),
    );
  }
}