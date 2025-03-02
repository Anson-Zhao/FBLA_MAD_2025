import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'EduVenture',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  final _pageController = PageController(); // PageController for sliding pages
  int _currentIndex = 0; // Track the current index

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      HomePageWidget(),
      ProgressPageWidget(),
      SelfStudyWidget(),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const ClampingScrollPhysics(), // Prevent overscroll bounce
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; // Update the current index
          });
        },
        children: tabs,
      ),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        currentIndex: _currentIndex,
        onTap: (i) {
          _pageController.animateToPage(
            i,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          setState(() {
            _currentIndex = i;
          });
        },
        backgroundColor: FlutterFlowTheme.of(context).secondary,
        selectedItemColor: FlutterFlowTheme.of(context).primary,
        unselectedItemColor: const Color(0x66FFFFFF),
        selectedBackgroundColor: const Color(0x00000000),
        borderRadius: 100.0,
        itemBorderRadius: 8.0,
        margin: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
        width: MediaQuery.sizeOf(context).width * 0.514,
        elevation: 60.0,
        items: [
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home_filled,
                  color: _currentIndex == 0
                      ? FlutterFlowTheme.of(context).primary
                      : const Color(0x66FFFFFF),
                  size: 24.0,
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bar_chart_rounded,
                  color: _currentIndex == 1
                      ? FlutterFlowTheme.of(context).primary
                      : const Color(0x66FFFFFF),
                  size: 24.0,
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  color: _currentIndex == 2
                      ? FlutterFlowTheme.of(context).primary
                      : const Color(0x66FFFFFF),
                  size: 24.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



