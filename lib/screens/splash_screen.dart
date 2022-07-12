import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.black, size: 40),
          ),
          const Center(
            child: Text('Loading...'),
          ),
        ],
      ),
    );
  }
}
