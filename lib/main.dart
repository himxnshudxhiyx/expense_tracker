import 'package:expense_tracker/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: ScreenUtilInit(
        builder: (context, child) => GetMaterialApp(
          theme: ThemeData(
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          ),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          enableLog: true,
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
