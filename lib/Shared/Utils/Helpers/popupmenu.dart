part of '../helpers.dart';

class PopUpMenuTile extends StatelessWidget {
  const PopUpMenuTile({required this.title, Key? key, this.isActive = false})
      : super(key: key);
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline6!.copyWith(
              color: isActive ? Color(0xff000000) : Color(0xff000000)),
        ),
      ],
    );
  }
}
