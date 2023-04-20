import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myquran/src/feature/all_surah/data/surah_service.dart';
import 'package:http/http.dart' as http;
import 'package:myquran/src/feature/home/presentation/screen/home_page.dart';
import 'package:myquran/src/feature/all_surah/presentation/cubit/surat_cubit.dart';
import 'package:myquran/src/feature/surah_detail/data/surah_detail_service.dart';
import 'package:myquran/src/feature/surah_detail/presentation/bloc/ayat_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SuratCubit(
                SurahService(
                  client: http.Client(),
                ),
              ),
            ),
            BlocProvider(
              create: (context) => AyatBloc(
                SurahDetailService(
                  client: http.Client(),
                ),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'My Quran',
            theme: ThemeData(
              primarySwatch: Colors.brown,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            home: const HomePage(),
          ),
        );
      },
    );
  }
}
