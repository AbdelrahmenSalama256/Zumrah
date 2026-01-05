import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgrader/upgrader.dart';
import 'package:zumrah/core/app/zumrah_home.dart';
import 'package:zumrah/core/cubit/global_cubit.dart';
import 'package:zumrah/core/network/local_network.dart';
import 'package:zumrah/core/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  // await Firebase.initializeApp();

  //! Orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //! Status Bar Settings
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  //! Service Locator
  initServiceLocator();
  //! Cache Helper
  await sl<CacheHelper>().init();
  // Initialize local + push notification handlers (requires CacheHelper)
  // await LocalNotificationService.init();
  // await NotificationHandler.init();
  //! Update Checker
  if (kDebugMode) {
    await Upgrader.clearSavedSettings();
  }
  //! Application Starts From here.
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GlobalCubit>()..init(),
        ),
      ],
      child: UpgradeAlert(
          upgrader: Upgrader(
            debugLogging: kDebugMode,
          ),
          dialogStyle: UpgradeDialogStyle.cupertino,
          child: const ZumrahHome()),
    ),
  );
}
