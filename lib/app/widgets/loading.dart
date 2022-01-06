import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      itemBuilder: (_, index) {
        return DecoratedBox(
          decoration: BoxDecoration(color: index.isEven ? Colors.blue : Colors.blue.shade800),
        );
      },
    );
  }
}
