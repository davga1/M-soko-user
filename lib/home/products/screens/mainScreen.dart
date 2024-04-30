import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/home_screen.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/bottom_sheet_menu.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/chat_list_screen.dart';
import 'package:m_soko/navigation/bottomNavigationItems/paymentsPage/payments_page.dart';
import 'package:m_soko/navigation/bottomNavigationItems/profilePage/profile_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

int index = 2;

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    setState(() {
      index = 2;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const ProfilePage(),
      const ChatListScreen(),
      const HomeScreen(),
      const PaymentsPage(),
    ];

    return Scaffold(
        body: pages[index],
        bottomNavigationBar: GNav(
          backgroundColor: ColorConstants.bgColour,
          color: Colors.white,
          textStyle: const TextStyle(color: Colors.white),
          tabActiveBorder: Border.all(),
          tabBackgroundColor: ColorConstants.blue900,
          iconSize: 17,
            onTabChange: (value) => {
                  if (value == 4)
                    {
                      showModalBottomSheet<void>(
                        context: context,
                        useRootNavigator: true,
                        builder: (BuildContext context) {
                          return bottomNavigaitonMenu(context);
                        },
                      )
                    }
                  else if(value != 4)
                    setState(() {
                      index = value;
                    })
                },
            selectedIndex: index,
            tabs:  const [
              GButton(
                iconColor: ColorConstants.blue900,
                iconActiveColor: Colors.white,
                icon: Icons.person,
                text: 'Profile',
              ),
              GButton(
                iconColor: ColorConstants.blue900,
                iconActiveColor: Colors.white,
                icon: CupertinoIcons.text_bubble,
                text: 'Chat',
              ),
              GButton(
                iconColor: ColorConstants.blue900,
                iconActiveColor: Colors.white,
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                iconColor: ColorConstants.blue900,
                iconActiveColor: Colors.white,
                icon: Icons.payment,
                text: 'Payments',
              ),
              GButton(
                iconColor: ColorConstants.blue900,
                iconActiveColor: Colors.white,
                icon: Icons.menu,
                text: 'Menu',
              )
            ])
        //  BottomNavigationBar(
        //     onTap: (value) {
        //       if (value == 4) {
        //         showModalBottomSheet<void>(
        //           context: context,
        //           useRootNavigator: true,
        //           builder: (BuildContext context) {
        //             return bottomNavigaitonMenu(context);
        //           },
        //         );
        //       } else if (value >= 0 && value < 4) {
        //         setState(() {
        //           index = value;
        //         });
        //       }
        //     },
        //     currentIndex: index,
        //     selectedItemColor: Colors.white,
        //     unselectedItemColor: Colors.black,
        //     type: BottomNavigationBarType.fixed,

        //     items: const [
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.person),
        //         label: '',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(CupertinoIcons.text_bubble),
        //         label: '',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.home),
        //         label: '',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.payment),
        //         label: '',
        //       ),
        //       BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
        //     ]),
        );
  }
}
