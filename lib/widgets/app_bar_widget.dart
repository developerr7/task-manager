import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/providers/navigation_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData actionIcon;
  final VoidCallback onActionPressed;
  final Color bgColor;
  final Color iconColor;
  final bool showLeadingIcon;
  final bool showActionIcon;
  final String? leadingIcon;
  final String? actionIconAsset;
  final Color? leadingIconColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actionIcon = Icons.settings,
    required this.onActionPressed,
    required this.bgColor,
    required this.iconColor,
    this.showLeadingIcon = true,
    this.showActionIcon = true,
    this.leadingIcon,
    this.actionIconAsset,
    this.leadingIconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: showLeadingIcon
              ? IconButton(
                  icon: leadingIcon != null
                      ? SvgPicture.asset(
                          leadingIcon!,
                          height: 30,
                          width: 30,
                          colorFilter: ColorFilter.mode(
                              leadingIconColor!, BlendMode.srcIn),
                        )
                      : Icon(
                          Icons.arrow_back,
                          color: iconColor,
                          size: 30,
                        ),
                  onPressed: () {
                    final navigationProvider =
                        Provider.of<NavigationProvider>(context, listen: false);

                    if (Navigator.of(context).canPop()) {
                      if (ModalRoute.of(context)?.settings.name == '/task') {
                        Navigator.pushReplacementNamed(context, '/');
                        navigationProvider.updateIndex(0);
                      } else {
                        Navigator.of(context).pop();
                      }
                    } else {
                      Navigator.of(context).maybePop();
                    }
                  },
                )
              : null,
          title: Text(
            title,
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: showActionIcon
              ? [
                  IconButton(
                    icon: actionIconAsset != null
                        ? SvgPicture.asset(
                            actionIconAsset!,
                            height: 30,
                            width: 30,
                          )
                        : Icon(
                            actionIcon,
                            color: iconColor,
                            size: 30,
                          ),
                    onPressed: onActionPressed,
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
