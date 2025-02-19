import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_app/cubit/meco_question_cubit.dart';
import 'package:memory_app/cubit/meta_question_cubit.dart';
import 'package:memory_app/cubit/name_jwt_cubit.dart';
import 'package:memory_app/cubit/static_list_cubit.dart';
import 'package:memory_app/screen/components/navigation_service.dart';
import 'package:memory_app/screen/login_screen.dart';

import 'cubit/time_ledger_list_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NameJwtCubit()),
        BlocProvider(create: (context) => MecoQuestionCubit()),
        BlocProvider(create: (context) => TimeLedgerListCubit()),
        BlocProvider(create: (context) => MetaQuestionCubit()),
        BlocProvider(create: (context) => StaticListCubit()),
      ],
      child: MaterialApp(
        title: 'Memory',
        theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF73648E),
            selectedItemColor: Colors.white,
            unselectedItemColor: Color(0xFF564B6A),
          ),
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,

        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        navigatorKey: NavigationService.navigatorKey,
      ),
    );
  }
}
