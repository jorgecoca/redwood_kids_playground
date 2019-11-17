import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

enum Sound {
  fart,
  horn,
}

class Car extends StatefulWidget {
  final Color color;
  final Sound sound;

  Car({
    Key key,
    @required this.sound,
    @required this.color,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Car();
}

class _Car extends State<Car> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  final minSize = 20.0;
  final maxSize = 200.0;
  var isMaxSize = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween<double>(
      begin: minSize,
      end: maxSize,
    ).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        print('Animation: $status, isMaxSize: $isMaxSize');
        if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
          setState(() {
            isMaxSize = !isMaxSize;
          });
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioCache = AudioCache();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.directions_car,
              color: widget.color,
              size: animation.value,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _InfoButton(
                icon: Icons.volume_up,
                text: 'Make sound',
                onPressed: () {
                  audioCache.play(_getSoundFile(widget.sound));
                },
              ),
              _InfoButton(
                icon: Icons.rotate_right,
                text: 'Move car',
                onPressed: () =>
                    isMaxSize ? controller.reverse() : controller.forward(),
              ),
            ],
          )
        ],
      ),
    );
  }

  String _getSoundFile(Sound sound) {
    switch (sound) {
      case Sound.fart:
        return 'fart.mp3';
      case Sound.horn:
      default:
        return 'horn.mp3';
    }
  }
}

class _InfoButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  _InfoButton({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Column(
        children: [
          Icon(icon, size: 50),
          Text(text),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
