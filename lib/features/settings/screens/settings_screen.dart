import 'package:f21_demo/core/custom_styles.dart';
import 'package:f21_demo/core/providers/settings_repository.dart';
import 'package:f21_demo/features/settings/widgets/settings_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final switchValue = ref.watch(settingsProvider).isDarkMode();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: viewportConstraints.maxHeight,
              maxWidth: viewportConstraints.maxWidth,
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: viewportConstraints.maxHeight,
                  maxWidth: viewportConstraints.maxWidth,
                ),
                child: Column(
                  children: [
                     const SettingsScreenTitle(title: "Genel"),
                    ListTile(
                      leading: Icon(Icons.language),
                      title: Text("Dil"),
                      subtitle: Text("Türkçe"),
                       onTap: () {
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text("Yalnızca türkçe destekleniyor."))
                         );
                       },
                    ),
                     const Divider(),
                    const SettingsScreenTitle(title: "Arayüz ve Ses"),
                    ListTile(
                      leading: const Icon(Icons.dark_mode),
                      title: const Text("Karanlık Mod"),
                      trailing: Switch(
                        activeColor: CustomStyles.buttonColor,
                        value: switchValue,
                        onChanged: (bool value) {
                          ref.read(settingsProvider.notifier).toggleDarkMode();
                        },
                      ),
                    ),
                    const Divider(),
                    const Spacer(),
                    const SettingsScreenTitle(title: "Uygulama Hakkında"),
                    const ListTile(
                      leading: Icon(Icons.developer_mode),
                      title: Text("F21 Ekibi Tarafından Geliştirilmiştir"),
                    ),
                    const ListTile(
                      leading: Icon(Icons.home),
                      title: Text("Oyun ve Uygulama Akademisi"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

