// import 'dart:ffi';

import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: double.infinity,
      width: 280.0,
      color: Theme.of(context).primaryColor,
      child: Column(children: [
        // first we have the logo
        // wrap the entire logo in a row and padding to get proper alignment
        Row(children: [
          Padding(
              padding: EdgeInsets.all(16),
              child: Image.asset(
                'assets/spotify_logo.png',
                height: 55,
                // removes blurriness
                filterQuality: FilterQuality.high,
              ))
        ]),
        _SideMenuTabIcon(
          title: "Home",
          iconData: Icons.home,
          onTap: () {},
        ),
        _SideMenuTabIcon(
          title: "Search",
          iconData: Icons.search,
          onTap: () {},
        ),
        _SideMenuTabIcon(
          title: "Radio",
          iconData: Icons.audiotrack,
          onTap: () {},
        )
      ]),
    );
  }
}

class _SideMenuTabIcon extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTap;
  const _SideMenuTabIcon(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          Icon(iconData, color: Theme.of(context).iconTheme.color, size: 28),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
      // in the even the side menu is small,
    );
  }
}
