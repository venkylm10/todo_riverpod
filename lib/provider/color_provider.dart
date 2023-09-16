import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final colorProvider = StateProvider<Map<String, Color>>(
  (ref) => {
    'Learning': Colors.green,
    'Work': Colors.blue.shade800,
    'General': Colors.amberAccent,
  },
);
