// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:smartfarm_dashboard/config/palette.dart';
import 'package:smartfarm_dashboard/data/grpc.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  var grpcSend = Grpc();

  void send() {
    // grpcSend.sendMessage();
    // tem = double.parse(redTemData);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh),
          iconSize: 28.0,
          onPressed: send,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
