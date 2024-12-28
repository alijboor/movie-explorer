import 'package:flutter/material.dart';
import 'package:movie_explorer/core/constants/lang_keys.dart';
import 'package:movie_explorer/features/home/providers/home_provider.dart';
import 'package:movie_explorer/features/home/widgets/home_body.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        final homeProvider = Provider.of<HomeProvider>(context);
        return Scaffold(
          appBar: AppBar(title: Text(LangKeys.home)),
          body: const HomeBody(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: const Icon(Icons.favorite, color: Colors.red, size: 35),
            onPressed: () => homeProvider.favManager.toFavScreen(context),
          ),
        );
      },
    );
  }
}
