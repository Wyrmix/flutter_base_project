
import 'package:flutter/material.dart';
import 'package:flutter_base_project/ui/routes/sample_router.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Starter',
      onGenerateRoute: SampleRouter().router.generator,
    );
  }
}
