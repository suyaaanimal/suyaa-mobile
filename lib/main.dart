import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suyaa_mobile/application/controller/auth.dart';
import 'package:suyaa_mobile/application/controller/server_setting.dart';
import 'package:suyaa_mobile/application/controller/user.dart';
import 'package:suyaa_mobile/application/state/auth.dart';
import 'package:suyaa_mobile/application/state/user.dart';
import 'package:suyaa_mobile/firebase_options.dart';
import 'package:suyaa_mobile/infrastructure/constant/debug.dart';
import 'package:suyaa_mobile/infrastructure/repository/auth.dart';
import 'package:suyaa_mobile/infrastructure/repository/server.dart';
import 'package:suyaa_mobile/infrastructure/repository/user.dart';
import 'package:suyaa_mobile/infrastructure/service/metamask/metamask.dart';
import 'package:suyaa_mobile/infrastructure/service/oauth2.dart';
import 'package:suyaa_mobile/infrastructure/service/server.dart';
import 'package:suyaa_mobile/infrastructure/service/shared_preferences.dart';
import 'package:suyaa_mobile/presentation/component/unbackable.dart';
import 'package:suyaa_mobile/presentation/page/auth/signin_page.dart';
import 'package:suyaa_mobile/presentation/page/home/home.dart';
import 'package:suyaa_mobile/presentation/page/home/item_shop.dart';
import 'package:suyaa_mobile/presentation/page/home/sleep_history/daily_sleep.dart';
import 'package:suyaa_mobile/presentation/page/home/sleep_history/sleep_history_page.dart';
import 'package:suyaa_mobile/presentation/page/home/timer.dart';
import 'package:suyaa_mobile/presentation/page/loading.dart';
import 'package:suyaa_mobile/presentation/page/opening/opening_page.dart';
import 'package:suyaa_mobile/presentation/page/setting/server_setting_page.dart';
import 'package:suyaa_mobile/presentation/page/start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
      providers: [
        // Service Layer
        Provider<Server>(
          create: (_) => Server(),
        ),
        Provider<Oauth2>(
          create: (_) => Oauth2(),
        ),
        // TODO(__atah_atah): 普通のproviderにする
        ChangeNotifierProvider<Metamask>(
          create: (_) => Metamask(),
        ),
        Provider<SharedPreferencesService>(
          create: (_) => SharedPreferencesService(),
        ),
      ],
      child: Builder(builder: (context) {
        return MultiProvider(
            providers: [
              // RepositoryLayer
              Provider<ServerRepository>(
                  create: (constext) => ServerRepository(
                        server: context.read<Server>(),
                      )),
              Provider<AuthRepository>(
                create: (context) => AuthRepository(
                  server: context.read<Server>(),
                  oauth2: context.read<Oauth2>(),
                  sp: context.read<SharedPreferencesService>(),
                ),
              ),
              Provider<UserRepository>(
                  create: (_) => UserRepository(
                        context.read<Server>(),
                      )),
            ],
            child: Builder(builder: (context) {
              // Service Layer w/o Auth
              return MultiProvider(providers: [
                Provider<ServerSetting>(
                    create: ((context) => ServerSetting(
                          serverRepository: context.read<ServerRepository>(),
                        ))),
                StateNotifierProvider<User, UserState>(
                    lazy: false,
                    create: (context) => User(
                          stream:
                              context.read<AuthRepository>().userStream.stream,
                          userRepository: context.read<UserRepository>(),
                        )),
              ], child: const MyApp());
            }));
      })));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  final title = 'Suyaa Animals';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final _router = GoRouter(
    initialLocation: !debug ? '/' : '/setting/server',
    routes: [
      GoRoute(
        path: '/',
        name: 'start',
        builder: (context, state) =>
            Unbackable(key: state.pageKey, child: const StartPage()),
        routes: [
          GoRoute(
            path: 'auth',
            name: 'signIn',
            builder: (context, state) =>
                Unbackable(key: state.pageKey, child: const LoginPage()),
          ),
          GoRoute(
            path: 'home',
            redirect: (state) => '/home/home',
            routes: [
              GoRoute(
                path: 'sleepHistory',
                name: 'sleepHistory',
                builder: (context, state) =>
                    SleepHistoryPage(key: state.pageKey),
                routes: [
                  GoRoute(
                    path: ':sid',
                    name: 'dairySleep',
                    builder: (context, state) {
                      final sid = state.params['sid']!;
                      return DailySleep(key: state.pageKey, sid: sid);
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'home',
                name: 'home',
                builder: (context, state) =>
                    Unbackable(key: state.pageKey, child: const MainPage()),
              ),
              GoRoute(
                path: 'itemShop',
                name: 'itemShop',
                builder: (context, state) => ItemShop(key: state.pageKey),
              ),
              GoRoute(
                path: 'timer',
                name: 'timer',
                builder: (context, state) => Timer(key: state.pageKey),
              ),
            ],
          ),
          GoRoute(
            path: 'opening',
            name: 'opening',
            builder: (context, state) => OpeningPage(key: state.pageKey),
          ),
          if (debug)
            GoRoute(
              path: 'setting/server',
              name: 'serverSettings',
              builder: (context, state) => Unbackable(
                  key: state.pageKey, child: const ServerSettingPage()),
            ),
          GoRoute(
            path: 'loading',
            name: 'loading',
            builder: (context, state) =>
                Unbackable(key: state.pageKey, child: const LoadingPage()),
          ),
        ],
      )
    ],
    errorBuilder: ((context, state) => Scaffold(
          body: Center(child: Text(state.error.toString())),
        )),
    redirect: (state) {
      /// サインインしてなくてもアクセスできるページ
      final safePage = [
        '/',
        '/opening',
        '/setting/server',
      ];

      final loading = auth.loading;
      final signIn = auth.signedIn;
      final fromp = state.queryParams['from'];
      final subloc = state.subloc;
      // debugPrint('------------------------');
      // debugPrint(
      //     'loading:$loading, signin:$signIn, fromp:$fromp, subloc:$subloc');

      // ロード中はクルクルを表示する。
      // debugPrint('loading');
      if (loading) return subloc == '/loading' ? null : '/loading?from=$subloc';
      // ロードが終了すると前のページに戻る
      // debugPrint('fin loading');
      if (subloc == '/loading') return fromp ?? '/home';

      // サインインしてなくてもアクセスできる
      // debugPrint('safe area');
      if (safePage.contains(subloc)) return null;

      // 未サインイン時はサインイン画面へ遷移
      // debugPrint('signing in');
      if (!signIn) return subloc == '/auth' ? null : '/auth?from=$subloc';
      // サインインが終了すると前のページへ戻る
      // debugPrint('signed in');
      if (subloc == '/auth') return fromp ?? '/home';

      // debugPrint('you can pass through');
      return null;
    },
    refreshListenable: GoRouterRefreshStream(auth.stream),
  );

  late final Auth auth;

  @override
  void initState() {
    super.initState();
    auth = Auth(authRepository: context.read<AuthRepository>());
  }

  @override
  Widget build(BuildContext context) =>
      StateNotifierProvider<Auth, AuthState>.value(
        value: auth,
        child: MaterialApp.router(
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          title: widget.title,
        ),
      );
}
