
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/welcome_screen.dart';
import '../../screens/portfolio_screen.dart';
import '../../screens/crud_screen.dart';
import '../../screens/login_screen.dart';
import '../../screens/register_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/',
      name: 'welcome',
      builder: (context, state) => WelcomeScreen(),
    ),
    GoRoute(
      path: '/portfolio',
      name: 'portfolio',
      builder: (context, state) => const PortfolioScreen(),
    ),
    GoRoute(
      path: '/crud',
      name: 'crud',
      builder: (context, state) => const CrudScreen(),
    ),
  ],
);
