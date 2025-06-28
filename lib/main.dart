import 'package:auth_test/presentation/theme/default_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/screens/auth/login/email_input_screen.dart';
import 'presentation/screens/auth/login/code_input_screen.dart';
import 'presentation/screens/auth/login/authorized_screen.dart';
import 'logic/auth/auth_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/email_input',
        routes: {
          '/email_input': (context) => const EmailInputScreen(),
          '/authorized': (context) => const AuthorizedScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/code_input') {
            final email = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => CodeInputScreen(email: email),
            );
          }
          return null;
        },
      ),
    );
  }
}
