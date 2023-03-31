import 'package:intl/intl.dart';

extension FormatDateTime on DateTime {
  String formatDateServer() {
    try {
      var dateString = DateFormat('EEE MMM d yyyy hh:mm:ss').format(this);
      return '$dateString GMT$timeZoneName';
    } catch (_) {
      return '';
    }
  }

  //2021-03-30T16:21:24.816Z
  String convertLocalDateTimeToServer() {
    try {
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(this);
    } catch (_) {
      return '';
    }
  }
}

extension ParseDateTime on String {
  //"2020-11-17T11:51:03.601152+07:00" -> '11:51 17/11/2020'
  String formatDDMMYYHhMm() {
    try {
      final str = split('+');
      var dateFromString = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(str[0], false);
      return DateFormat('dd/MM/yyyy HH:mm').format(dateFromString);
    } catch (e) {
      print(e);
      return '';
    }
  }

  //"2020-11-17T11:51:03.601152+07:00" -> '17/11/2020'
  String formatDDMMYY() {
    try {
      final str = split('+');
      var dateFromString = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(str[0], false);
      return DateFormat('dd/MM/yyyy').format(dateFromString);
    } catch (e) {
      print(e);
      return '';
    }
  }

  String formatYYYYMMDDToDDMMYYY() {
    try {
      final str = split('+');
      var dateFromString = DateFormat("yyyy-MM-dd").parse(str[0], false);
      return DateFormat('dd/MM/yyyy').format(dateFromString);
    } catch (e) {
      print(e);
      return '';
    }
  }

  String formatDayOfWeek() {
    try {
      final str = split('+');
      var dateFromString = DateFormat("yyyy-MM-dd").parse(str[0], false);
      var dayOfWeek = DateFormat('EEE').format(dateFromString);
      if (dayOfWeek == 'Mon') {
        return 'Thứ 2';
      } else if (dayOfWeek == 'Tue') {
        return 'Thứ 3';
      } else if (dayOfWeek == 'Wed') {
        return 'Thứ 4';
      } else if (dayOfWeek == 'Thu') {
        return 'Thứ 5';
      } else if (dayOfWeek == 'Fri') {
        return 'Thứ 6';
      } else if (dayOfWeek == 'Sat') {
        return 'Thứ 7';
      } else {
        return 'Chủ nhật';
      }
    } catch (e) {
      print(e);
      return '';
    }
  }

  String formatYYYYMMDD() {
    try {
      final str = split('+');
      var dateFromString = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(str[0], false);
      return DateFormat('yyyy-MM-dd').format(dateFromString);
    } catch (e) {
      print(e);
      return '';
    }
  }
}
