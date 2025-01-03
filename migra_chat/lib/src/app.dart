import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart' as AppLocalizations;
import 'package:migra_chat/src/ui/chat/chat.dart';
import 'package:migra_chat/src/ui/forms/forms.dart';
import 'package:migra_chat/src/ui/forms/pdf_edit.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import '../src/ui/intake/intake.dart';
import 'ui/family_tree/family_tree.dart';
import 'ui/landing/landing.dart';
import 'ui/home/home.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          // localizationsDelegates: [
          //   AppLocalizations.delegate,
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('es', ''), // Spanish, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          // onGenerateTitle: (BuildContext context) =>
          //     AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                  case SampleItemListView.routeName:
                  default:
                    return const SampleItemListView();
                }
              },
            );
          },
          routes: {
            '/intake': (context) => const SafeArea(child: UserIntake()),
            '/home': (context) => const SafeArea(child: HomePage()),
            '/family_tree': (context) => const SafeArea(child: FamilyTree()),
            '/landing': (context) => const SafeArea(child: LandingPage()),
            '/chat': (context) => const SafeArea(child: ChatPage()),
            '/forms': (context) => const SafeArea(child: FormsPage()),
            '/pdf_edit': (context) => const SafeArea(child: PDFEditPage()),
          },
          home: const SafeArea(child: UserIntake()),
        );
      },
    );
  }
}
