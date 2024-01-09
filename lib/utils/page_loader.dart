import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_pos_adminpanell/utils/color.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.prograssiveDots(
        color: kLoaderColor,
        size: 75,
      ),
    );
  }
}
