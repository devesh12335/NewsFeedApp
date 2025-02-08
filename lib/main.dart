import 'package:news_app/global_state/globalState.dart';
import 'package:news_app/presentation/resources/color_manager.dart';
import 'package:news_app/presentation/resources/theme/theme_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/screens/home/bloc.dart';
import 'package:news_app/presentation/screens/home/view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ColorManager().loadPrimaryColor();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    loadThemePreference().then((value) {
      GlobalState.instance.isDarkMode.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GlobalState.instance.isDarkMode,
        builder: (context, isDarkMode, _) {
          return MultiBlocProvider(
              providers: [BlocProvider(create: (_) => HomeBloc())],
              child: MaterialApp(
                navigatorKey: GlobalState.instance.navigatorKey,
                debugShowCheckedModeBanner: false,
                // initialRoute: Routes.splashPage,
                // onGenerateRoute: RouteGenerator.getRoute,
                home: HomePage(
                  isDarkMode: isDarkMode,
                ),
                theme: isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme,
              ));
        });
  }
}
