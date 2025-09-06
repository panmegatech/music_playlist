import 'package:flutter/material.dart';
import 'package:music_playlist/features/core/routes/route_name.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "404 Page not found",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Sorry, We could't find the page.",
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteName.musicList,
                    (route) => false, // ลบทุกหน้าออกจาก Stack
                  ),
              child: const Text(
                "Go to your dashboard",
              ))
        ],
      )),
    );
  }
}
