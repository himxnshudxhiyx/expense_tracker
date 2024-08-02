import 'package:expense_tracker/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/functions/api_manager.dart';

void main() {
  runApp(const MyApp());
}

ApiManager apiManager = ApiManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(color: Colors.deepPurple),
            textTheme: GoogleFonts.poppinsTextTheme(textTheme).copyWith(),
          ),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          enableLog: true,
          debugShowCheckedModeBanner: false,
          // builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
