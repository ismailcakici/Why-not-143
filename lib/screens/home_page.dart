import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:why_not_143_team/constant.dart/asset_path.dart';
import 'package:why_not_143_team/constant.dart/color_constant.dart';
import 'package:why_not_143_team/constant.dart/padding_constant.dart';
import 'package:why_not_143_team/constant.dart/text_style.dart';
import 'package:why_not_143_team/route/route_constant.dart';
import 'package:why_not_143_team/screens/form_page.dart';
import 'package:why_not_143_team/screens/nav_page.dart';
import 'package:why_not_143_team/services/firebase_auth_method.dart';
import 'package:why_not_143_team/widget/menu_item_widget.dart';
import '../constant.dart/string.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late int defaultChoiceIndex;

  double? screenHeight, screenWidth;

  bool openMenu = false;
  @override
  void initState() {
    defaultChoiceIndex = 0;
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _firebaseUser = context.watch<User?>();
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          _menu(_firebaseUser, context),
          AnimatedPositioned(
              top: openMenu ? 0.1 * screenHeight! : 0,
              bottom: openMenu ? 0.2 * screenWidth! : 0,
              left: openMenu ? 0.5 * screenWidth! : 0,
              duration: const Duration(milliseconds: 500),
              child: Material(
                color: ColorConstant.instance.white,
                elevation: 15,
                borderRadius: openMenu
                    ? const BorderRadius.all(Radius.circular(20))
                    : null,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: screenHeight,
                    width: screenWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _homeAppBar(),
                            if (_firebaseUser != null)
                              ElevatedButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const FormPage())));
                                  },
                                  child: const Text("Patim ol"))
                            else
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RouteConstant.loginScreenRoute);
                                },
                                child: const Text("Patim ol"),
                              ),
                            homeCard(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
          openMenu ? const Text("") : NavPage(),
        ]),
      ),
    );
  }

  Padding homeCard() {
    return Padding(
      padding: PaddingConstant.instance.loginPadding,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 141.h,
          width: 349.w,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
                  ColorConstant.instance.cardColor,
                  Colors.orangeAccent,
                ],
              ),
              color: ColorConstant.instance.cardColor,
              borderRadius: BorderRadius.circular(15)),
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 80.h,
                        width: 80.w,
                        child: Image.asset(
                          AssetPath.instance.cat1,
                        ),
                      ),
                    ],
                  ),
                  Lottie.asset(
                    AssetPath.instance.cardImage,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 80.h,
                        width: 80.w,
                        child: Image.asset(
                          AssetPath.instance.cat2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      elevation: 0,
                      primary: Colors.transparent,
                      onPrimary: ColorConstant.instance.yankeBlue,
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: PaddingConstant.instance.loginPadding,
                      child: Text(
                        "Bağış Yap",
                        style: TextStyleConstant.instance.textSmallMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SlideTransition _menu(User? _firebaseUser, BuildContext context) {
    return SlideTransition(
        position: _offsetAnimation,
        child: Container(
          height: screenHeight,
          color: ColorConstant.instance.white,
          child: Padding(
            padding: EdgeInsets.only(left: 18.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _firebaseUser != null
                        ? Padding(
                            padding: PaddingConstant.instance.loginPadding,
                            child: SizedBox(
                              height: 75.h,
                              width: 75.w,
                              child: CircleAvatar(
                                child:
                                    Image.network("${_firebaseUser.photoURL}"),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 75.h,
                            width: 75.w,
                            child: CircleAvatar(
                                child:
                                    Image.asset(AssetPath.instance.menuPerson)),
                          ),
                    SizedBox(
                      height: 16.h,
                    ),
                    _firebaseUser != null
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteConstant.profileRoute);
                            },
                            child: MenuItem(
                              icons: Icons.person,
                              text: "${_firebaseUser.displayName}",
                              page: RouteConstant.profileRoute,
                            ),
                          )
                        : MenuItem(
                            icons: Icons.person,
                            text: StringConstant.instance.menuPerson,
                            //TODO:tıklanıldığında toast mesaj gösterip giriş yapın denecek
                            page: RouteConstant.homeScreenRoute,
                          ),
                    SizedBox(
                      height: 16.h,
                    ),
                    MenuItem(
                      icons: Icons.info_outline,
                      text: StringConstant.instance.menuAbout,
                      page: RouteConstant.aboutScreenRoute,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    MenuItem(
                      icons: Icons.send,
                      text: StringConstant.instance.menuSendBack,
                      page: RouteConstant.feedBackScreenRoute,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    MenuItem(
                      icons: Icons.star,
                      text: StringConstant.instance.menuRateOurApp,
                      page: RouteConstant.homeScreenRoute,
                    ),
                    SizedBox(
                      height: 150.h,
                    ),
                    _firebaseUser != null
                        ? Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  context
                                      .read<FirebaseAuthMethods>()
                                      .signOut(context)
                                      .then((value) => Navigator.pushNamed(
                                          context,
                                          RouteConstant.coverScreenRoue));
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.logout_outlined,
                                      color: ColorConstant.instance.yankeBlue,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        StringConstant.instance.logOut,
                                        style: TextStyleConstant
                                            .instance.textLargeRegular,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteConstant.loginScreenRoute);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.login_outlined,
                                      color: ColorConstant.instance.yankeBlue,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        StringConstant.instance.loginSignIn,
                                        style: TextStyleConstant
                                            .instance.textLargeRegular,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                  ]),
            ),
          ),
        ));
  }

  _homeAppBar() {
    return AppBar(
      leadingWidth: 80,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          setState(() {
            openMenu = !openMenu;
          });
        },
        icon: Icon(
          Icons.menu,
          color: ColorConstant.instance.yankeBlue,
        ),
      ),
      centerTitle: true,
      title: Text(StringConstant.instance.homePage,
          style: GoogleFonts.poppins(color: ColorConstant.instance.yankeBlue)),
    );
  }
}
