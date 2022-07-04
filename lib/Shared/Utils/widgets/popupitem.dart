part of '../helpers.dart';

var isLoggedin = false.obs;
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
void showPopupMenu(BuildContext context, bool isThispage, bool isHis) {
  showMenu<int>(
    context: context,
    position: const RelativeRect.fromLTRB(25.0, 25.0, 0.0,
        0.0), //position where you want to show the menu on screen
    items: [
      isThispage
          ? const PopupMenuItem<int>(
              value: 1,
              child: PopUpMenuTile(
                isActive: true,
                title: 'Information',
              ))
          : PopupMenuItem(height: 0, child: Container()),
      isHis
          ? const PopupMenuItem<int>(
              value: 2,
              child: PopUpMenuTile(
                isActive: true,
                title: 'History',
              ))
          : PopupMenuItem(height: 0, child: Container()),
      const PopupMenuItem<int>(
          value: 3,
          child: PopUpMenuTile(
            title: 'Sign in',
          )),
    ],
    elevation: 8.0,
  ).then((itemSelected) async {
    switch (itemSelected) {
      case 1:
        Get.to(const Informartion());
        break;
      case 2:
        final SharedPreferences prefs = await _prefs;
        isLoggedin.value = prefs.getBool("isSubscribed") ?? false;
        isLoggedin.value
            ? Get.to(CalendarView())
            : Get.to(() => const Signin());
        break;
      case 3:
        Get.to(() => const Signin());
        break;
      default:
    }
  });
}
