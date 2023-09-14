import 'package:flutter/material.dart';

class RadioWidget extends StatelessWidget {
  final String title;
  final Color categoryColor;
  const RadioWidget({
    super.key,
    required this.title,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: categoryColor,
        ),
        child: RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(
              offset: const Offset(-22, 0),
              child: Text(
                title,
                style: TextStyle(
                  color: categoryColor,
                  fontWeight: FontWeight.w700,
                ),
              )),
          value: 1,
          groupValue: 0,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
