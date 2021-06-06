import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class PlanetFlare extends StatelessWidget {
  const PlanetFlare({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: const FlareActor(
        'assets/flare/WorldSpin.flr',
        fit: BoxFit.contain,
        animation: "roll",
      ),
    );
  }
}