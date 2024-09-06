import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/constants/app_colors.dart';
import 'package:tasky_app/providers/navigation_provider.dart';

class BannerCard extends StatelessWidget {
  final String primaryText;
  final String backgroundImage;
  final String logo;
  final double? logoHeight;
  final double? logoWidth;

  const BannerCard({
    super.key,
    required this.primaryText,
    required this.backgroundImage,
    required this.logo,
    this.logoHeight = 100,
    this.logoWidth = 100,
  });

  void _navigateToTaskListScreen(BuildContext context) {
    final navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    navigationProvider.updateIndex(1);
    Navigator.pushNamed(context, '/task');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Card(
        color: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 1,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SvgPicture.asset(
                backgroundImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      primaryText,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _navigateToTaskListScreen(context),
                    child: SizedBox(
                      width: 70,
                      child: SvgPicture.asset(
                        logo,
                        width: logoWidth,
                        height: logoHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
