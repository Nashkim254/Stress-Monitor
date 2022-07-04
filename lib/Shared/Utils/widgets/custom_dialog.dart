part of '../helpers.dart';

class ConfirmDialog extends StatelessWidget {
   ConfirmDialog({
    required this.message,
    required this.onPressed,
    required this.color,
    Key? key,
    
  }) : super(key: key);

  final String message;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: contentBox(context),
    );
  }

  Widget contentBox(context) {
    final theme = Theme.of(context);
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.close),
              color: blackColor,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 19, right: 19),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: message,
                      style: theme.textTheme.bodyText1!.copyWith(
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 19),
            Padding(
              padding: const EdgeInsets.only(left: 19, right: 19),
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  'OK',
                  style: theme.textTheme.bodyText1!.copyWith(
                    color: cardLightColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  fixedSize: Size(MediaQuery.of(context).size.width, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 21),
          ],
        ),
      ),
    );
  }
}
