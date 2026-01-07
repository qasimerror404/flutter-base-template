import 'package:flutter/material.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

/// Home page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.home),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              size: 64,
              color: context.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.welcome,
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.appName,
              style: context.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

