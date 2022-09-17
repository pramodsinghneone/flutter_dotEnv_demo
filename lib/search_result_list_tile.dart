import 'package:flutter/material.dart';

class SerchResultListTile extends StatelessWidget {
  final VoidCallback press;
  final String location;
  const SerchResultListTile(
      {super.key, required this.location, required this.press});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            location,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          onTap: press,
          horizontalTitleGap: 0,
          leading: const Icon(Icons.location_city),
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: Colors.grey,
        ),
      ],
    );
  }
}
