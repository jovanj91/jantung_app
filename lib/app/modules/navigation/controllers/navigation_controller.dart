import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jantung_app/app/data/services/auth/service.dart';
import 'package:jantung_app/app/modules/home/bindings/home_binding.dart';
import 'package:jantung_app/app/modules/home/views/home_view.dart';
import 'package:jantung_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:jantung_app/app/modules/profile/views/profile_view.dart';
import 'package:jantung_app/routes/app_pages.dart';

class NavigationController extends GetxController
    with GetTickerProviderStateMixin {
  AuthService? auth;
  late AnimationController fabAnimationController;
  late AnimationController borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController hideBottomBarAnimationController;

  var selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    this.auth = Get.find<AuthService>();

    this.fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    this.borderRadiusAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    this.fabCurve = CurvedAnimation(
      parent: fabAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    this.borderRadiusCurve = CurvedAnimation(
      parent: borderRadiusAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    this.fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    this.borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    this.hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      Duration(seconds: 1),
      () => this.fabAnimationController.forward(),
    );
    Future.delayed(
      Duration(seconds: 1),
      () => this.borderRadiusAnimationController.forward(),
    );
    super.onInit();
  }

  final pages = <String>[Routes.HOME, Routes.PROFILE];

  final iconList = <IconData>[
    Icons.home,
    Icons.person,
  ];

  final currentindex = 0.obs;
  changePage(index) {
    this.currentindex.value = index;
    Get.offAllNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.HOME) {
      return GetPageRoute(
          settings: settings,
          page: () => HomeView(),
          transition: Transition.leftToRight,
          binding: HomeBinding());
    }
    if (settings.name == Routes.PROFILE) {
      return GetPageRoute(
          settings: settings,
          page: () => ProfileView(),
          transition: Transition.rightToLeft,
          binding: ProfileBinding());
    }
    return null;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      //initialEntryMode: DatePickerEntryMode.input,
      // initialDatePickerMode: DatePickerMode.year,
      helpText: 'Date of Birth',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'DOB',
      fieldHintText: 'Month/Date/Year',
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  dateOutput() {
    var now = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
    var selected =
        DateFormat("dd-MM-yyyy").format(selectedDate.value).toString();
    if (now != selected) {
      return DateFormat("dd-MM-yyyy").format(selectedDate.value).toString();
    } else {
      return "Choose Date Of Birth";
    }
  }
}
