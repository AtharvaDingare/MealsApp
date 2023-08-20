import 'package:flutter/material.dart';

class Listtile extends StatelessWidget {
  const Listtile({
    super.key,
    required this.tileTitle,
    required this.tileIcon,
    required this.changescreen,
  });

  final String tileTitle;
  final IconData tileIcon;
  final void Function(String) changescreen;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        tileIcon,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      title: Text(
        tileTitle,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 20,
            ),
      ),
      onTap: () {
        changescreen(tileTitle);
      },
    );
  }
}
