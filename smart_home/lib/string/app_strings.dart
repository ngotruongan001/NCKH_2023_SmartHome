import 'package:get/get.dart';

import 'en_strings.dart';
import 'vi_strings.dart';

class AppStrings extends Translations {
  static const String localeCodeVi = 'vi';
  static const String localeCodeEn = 'en';

  @override
  Map<String, Map<String, String>> get keys => {
        localeCodeVi: viStrings,
        localeCodeEn: enStrings,
      };

  static String getString(String key) {
    var selectedLanguage =
        Get.locale.toString() == localeCodeEn ? enStrings : viStrings;
    var text = key;
    if (selectedLanguage.containsKey(key) && selectedLanguage[key] != null) {
      text = selectedLanguage[key] ?? key;
    }
    return text;
  }

  static String appTitle = 'appTitle';
  static String commonError = 'commonError';
  static String loginTitle = 'loginTitle';
  static String demo = 'demo';
  static String manageDeliveryTitle = 'manageDeliveryTitle';
  static String detailDeliveryTitle = 'detailDeliveryTitle';
  static String all = 'all';
  static String finishedDelivery = 'finishedDelivery';
  static String pending = 'pending';
  static String waiting = 'waiting';
  static String vehicleNumber = 'vehicleNumber';
  static String deliveryCode = 'deliveryCode';
  static String seeDetail = 'seeDetail';
  static String batchBrowsing = 'batchBrowsing';
  static String setDate = 'setDate';
  static String SGF = 'SGF';
  static String pickUpLocationTitle = 'pickUpLocationTitle';
  static String placeOfDeleveryTitle = 'placeOfDeleveryTitle';
  static String notyfiComeTitle = 'notyfiComeTitle';
  static String receivedTitle = 'receivedTitle';
  static String registerTitle = 'registerTitle';
  static String forgotPasswordTitle = 'forgotPasswordTitle';
  static String phoneNumber = 'phoneNumber';
  static String password = 'password';
  static String errorPhoneNumber = 'errorPhoneNumber';
  static String errorPassword = 'errorPassword';
  static String loading = 'loading';
  static String errorLoading = 'errorLoading';
  static String confirm = 'confirm';
  static String back = 'back';
  static String batchBrowsingConfirmation = 'batchBrowsingConfirmation';
  static String pleaseSelectCustomer = 'pleaseSelectCustomer';
  static String selectCustomer = 'selectCustomer';
  static String filterAndSearch = 'filterAndSearch';
  static String pleaseInputKeyWord = 'pleaseInputKeyWord';
  static String fromDate = 'fromDate';
  static String toDate = 'toDate';
  static String complete = 'complete';
  static String listDrivers = 'listDrivers';
  static String listCar = 'listCar';
  static String detailTitle = 'detailTitle';
  static String modifyProfile = 'modifyProfile';
  static String changeVehicle = 'changeVehicle';
  static String notification = 'notification';
  static String logout = 'logout';
  static String listDeliveryTitle = 'listDeliveryTitle';
  static String cancel = 'cancel';
  static String end = 'end';
  static String tracking = 'tracking';
  static String update = 'update';
  static String deliveryDate = "deliveryDate";
  static String receivedDate = "receivedDate";
  static String customer = "customer";
  static String noData = 'noData';
  static String anErrorOccurred = 'anErrorOccurred';
  static String fromDay = 'fromDay';
  static String toDay = 'toDay';
  static String done = 'done';
  static String informationAccount = 'informationAccount';

  static String hintTextFieldSearch = 'hintTextFieldSearch';
  static String filterFollow = 'filterFollow';
  static String tripNotCreated = 'tripNotCreated';
  static String receivedGoods = 'receivedGoods';
  static String feeApproved = 'feeApproved';
  static String tripApproved = 'tripApproved';
  static String denied = 'denied';
  static String delivered = 'delivered';
  static String noNewTripDriver = 'noNewTripDriver';
  static String history = 'history';
  static String editInformation = 'editInformation';

  static String firstNameAndLastName = 'firstNameAndLastName';
  static String birthday = 'birthday';
  static String email = 'email';
  static String identityCard = 'identityCard';
  static String reload = 'reload';
  static String search = 'search';
  static String enterTheReasonForEndingTheTrip =
      'enterTheReasonForEndingTheTrip';
  static String inputNameCustomer = 'inputNameCustomer';
  static String viewDetail = 'viewDetail';
  static String flightCode = 'flightCode';
  static String status = 'status';
  static String transshipment = 'transshipment';
  static String doneDelivery = 'doneDelivery';
  static String unfinished = 'unfinished';
  static String increaseBo = 'increaseBo';
}
