import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:todo_list_application/Features/home%20layout/view/widget/home_view.dart';
import 'package:todo_list_application/Features/home%20layout/view/widget/item_drawer.dart';
import 'package:todo_list_application/Features/home%20layout/view/widget/menu_view_page.dart';

class HomeLayout extends StatelessWidget{
  const HomeLayout({super.key});
  static const routeName = "HomeLayout";
  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
        angle: 0,
        mainScreenScale: 0.1,
        borderRadius: 40,
        menuBackgroundColor: Color(0xff617afd),
        menuScreen: MenuViewPage(),
        mainScreen: HomeView(),
    );
  }
}
