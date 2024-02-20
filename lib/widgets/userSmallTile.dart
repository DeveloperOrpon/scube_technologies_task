import 'package:flutter/cupertino.dart';

class StatusChip extends StatelessWidget {
  final Color color;
  final String title;
  final String name;

  const StatusChip(
      {super.key,
        required this.color,
        required this.title,
        required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.3),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: color,
          width: .5,
        ),
      ),
      child: Row(
        children: [
          Container(

            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
              color: color,
            ),
            child: Text(
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              title,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              name,
              style: const TextStyle(
                fontSize: 12,
                color: CupertinoColors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}
