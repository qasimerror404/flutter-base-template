import 'package:flutter/material.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

/// Settings page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notifications'),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            leading: const Icon(Icons.fingerprint),
            title: Text(context.l10n.biometricAuthentication),
            trailing: Switch(
              value: false,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}

