import 'package:fashion_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fashion_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:fashion_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>(),),
        BlocProvider(create: (context) => getIt<HomeCubit>(),)
      ],
      child: MaterialApp(
        title: 'Fashion App',
        debugShowCheckedModeBanner: false,
        home: SignUpScreen(),
      ),
    );
  }
}


