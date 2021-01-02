import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../constants/colorConstant.dart';
import '../constants/inkwell.dart';

class HomeScreenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kprimaryColor,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "Meraj",
                style: const TextStyle(
                    color: Color(0xff213e3b),
                    fontSize: 18.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500),
              ),
              accountEmail: Text(
                'Hussainimeeraj5@gmail.com',
                style: const TextStyle(
                    color: Color(0xff213e3b),
                    fontSize: 14.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w300),
              ),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  print('pressed');
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg',
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: kwhiteAlternateColor,
              ),
            ),
            Container(
              color: kprimaryColor,
              alignment: Alignment.center,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Home Page',
                      style: TextStyle(
                          color: kwhiteAlternateColor,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600),
                    ),
                    leading: Icon(
                      Icons.home,
                      color: kwhiteAlternateColor,
                    ),
                  ),
                  SizedBox(
                    width: 200.0,
                    height: 10.0,
                    child: Divider(
                      height: 3.0,
                      color: kwhiteAlternateColor,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'About Us',
                      style: TextStyle(
                          color: kwhiteAlternateColor,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600),
                    ),
                    leading: Icon(
                      Icons.people,
                      color: kwhiteAlternateColor,
                    ),
                  ),
                  SizedBox(
                    width: 200.0,
                    height: 10.0,
                    child: Divider(
                      height: 3.0,
                      color: kwhiteAlternateColor,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Feedback',
                      style: TextStyle(
                          color: kwhiteAlternateColor,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600),
                    ),
                    leading: Icon(
                      Icons.feedback,
                      color: kwhiteAlternateColor,
                    ),
                  ),
                  SizedBox(
                    width: 200.0,
                    height: 10.0,
                    child: Divider(
                      height: 3.0,
                      color: kwhiteAlternateColor,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Contact Us',
                      style: TextStyle(
                          color: kwhiteAlternateColor,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600),
                    ),
                    leading: Icon(
                      Icons.contact_page,
                      color: kwhiteAlternateColor,
                    ),
                  ),
                  SizedBox(
                    width: 200.0,
                    height: 10.0,
                    child: Divider(
                      height: 3.0,
                      color: kwhiteAlternateColor,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Provider.of<Auth>(context, listen: false).authlogout();
                    },
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          color: kwhiteAlternateColor,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600),
                    ),
                    leading: Icon(
                      Icons.logout,
                      color: kwhiteAlternateColor,
                    ),
                  ),
                  SizedBox(
                    width: 200.0,
                    height: 10.0,
                    child: Divider(
                      height: 3.0,
                      color: kwhiteAlternateColor,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Exit',
                      style: TextStyle(
                          color: kwhiteAlternateColor,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600),
                    ),
                    leading: Icon(
                      Icons.exit_to_app,
                      color: kwhiteAlternateColor,
                    ),
                  ),
                  SizedBox(
                    width: 200.0,
                    height: 10.0,
                    child: Divider(
                      height: 3.0,
                      color: kwhiteAlternateColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
