import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jantung_app/app/data/services/auth/service.dart';
import 'package:jantung_app/app/data/services/patient/service.dart';
import 'package:jantung_app/app/modules/home/bindings/home_binding.dart';
import 'package:jantung_app/app/modules/home/controllers/home_controller.dart';
import 'package:jantung_app/app/modules/home/views/home_view.dart';
import 'package:jantung_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:jantung_app/app/modules/profile/views/profile_view.dart';
import 'package:jantung_app/core/utils/get_errors.dart';
import 'package:jantung_app/core/values/constant.dart';
import 'package:jantung_app/routes/app_pages.dart';

class NavigationController extends GetxController
    with GetTickerProviderStateMixin {
  AuthService? auth;
  PatientService? patient;
  final HomeController homecon = Get.find<HomeController>();
  late AnimationController fabAnimationController;
  late AnimationController borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController hideBottomBarAnimationController;

  @override
  void onInit() {
    this.auth = Get.find<AuthService>();
    this.patient = Get.find<PatientService>();

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

    this
        .patient
        ?.patientData
        .update((patientData) => patientData?.patientGender = null);

    this
        .patient
        ?.patientData
        .update((patientData) => patientData?.patientGender = null);

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

  var selectedDate = DateTime.now().obs;
  var now = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
  var isDataProcessing = false.obs;

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
      lastDate: DateTime.now(),
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
    var formatedpickeddate =
        DateFormat("yyyy-MM-dd").format(selectedDate.value).toString();
    this
        .patient
        ?.patientData
        .update((patientData) => patientData?.patientDob = formatedpickeddate);
  }

  dateOutput() {
    var selected =
        DateFormat("dd-MM-yyyy").format(selectedDate.value).toString();
    if (now != selected) {
      return DateFormat("dd-MM-yyyy").format(selectedDate.value).toString();
    } else {
      return "Choose Date Of Birth";
    }
  }

  addPatient() async {
    try {
      isDataProcessing(true);
      await this
          .patient
          ?.addPatient(
              this.patient?.patientData.value.patientName,
              this.patient?.patientData.value.patientGender,
              this.patient?.patientData.value.patientDob)
          .then((response) {
        print(response);
        print(this.patient?.patientData.value.patientDob);
        if (VerifyError.verify(response)) {
          Get.snackbar('Failed, try again', response.getError(),
              snackPosition: SnackPosition.TOP);
          addPatient();
        } else {
          isDataProcessing(false);
          select.value = 0;
          selectedDate.value = DateTime.now();
          Get.back();
          Get.snackbar('Patient Added', 'Patient Added Successfully',
              snackPosition: SnackPosition.TOP);
          homecon.refreshList();
        }
      }, onError: (err) {
        Get.snackbar('Failed add Patient', err.toString(),
            snackPosition: SnackPosition.TOP);
      });
    } catch (e) {
      Get.snackbar('Failed add Patient', e.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }

  changeName(v) => this
      .patient
      ?.patientData
      .update((patientData) => patientData?.patientName = v);

  savedName(v) => this
      .patient
      ?.patientData
      .update((patientData) => patientData?.patientName = v);

  validateName(v) => v.length > 0 ? null : 'Please Fill This Field';

  List gender = [0, 1];
  var select = 0.obs;

  changeGender(v) {
    this
        .patient
        ?.patientData
        .update((patientData) => patientData?.patientGender = v);
  }

  defaultGender() {
    if (select.value == 0) {
      this
          .patient
          ?.patientData
          .update((patientData) => patientData?.patientGender = 0);
    }
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(() => Radio(
              activeColor: kPrimaryColor,
              value: gender[btnValue],
              groupValue: select.value,
              onChanged: (value) {
                select.value = value;
                changeGender(value);
              },
            )),
        Text(title)
      ],
    );
  }
}
