import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> UserProvider()),
      ],

      child: const MyApp()
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  final AuthService authService = AuthService();


  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  } 

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Amazon Clone",
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.greyBackgroundCOlor,
        colorScheme:const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: GlobalVariables.greyBackgroundCOlor,
          iconTheme:  IconThemeData(color: Colors.black)
        ),
        useMaterial3: true,
      ),

      onGenerateRoute:(settings) => generateRoute(settings),

      home: Provider.of<UserProvider>(context).user.token.isNotEmpty 
      ? Provider.of<UserProvider>(context).user.type == 'user' ? const BottomBar() :const AdminScreen()
      : const  AuthScreen(),
    );
  }
}