import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'package:intl/intl.dart';

class AppUtils {
  ///To check internet connection
  static Future<bool> hasInternet() async {
    try {
      final url = Uri.parse('https://flutter-amr.noviindus.in/api/');
      final response = await http.get(url);
      return response.statusCode == 200;
    } catch (e) {
      return false; // Request failed, so no internet connection
    }
  }

  /// Navigate to a new screen/widget
  static navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static String calculateTimeDifference(
      DateTime? checkInTime, DateTime? checkOutTime) {
    if (checkInTime == null) {
      return "00:00";
    }
    DateTime actualCheckOutTime = checkOutTime ?? DateTime.now();

    // debugPrint("checkInTime:--- " + checkInTime.toString());
    // debugPrint("checkOutTime:--- " + checkOutTime.toString());
    // If check-out time is null, use the current time
    // Convert to IST (UTC + 5:30)
    // Duration istOffset = Duration(hours: 5, minutes: 30);
    // DateTime checkInIST = checkInTime.add(istOffset);
    // DateTime checkOutIST = actualCheckOutTime.add(istOffset);
    //
    // // Calculate the difference
    // Duration difference = checkOutIST.difference(checkInIST);
    // Convert to local time
    DateTime checkInLocal = checkInTime.toLocal();
    DateTime checkOutLocal = actualCheckOutTime.toLocal();
    // debugPrint("checkInLocal:--- " + checkInLocal.toString());
    // debugPrint("checkOutLocal:--- " + checkOutLocal.toString());

    // Calculate the difference
    Duration difference = checkOutLocal.difference(checkInLocal);
    // Format the difference as "HH:MM"
    String formattedDifference =
        difference.toString().split('.').first.padLeft(8, '0').substring(0, 5);
    return formattedDifference;
  }

  static String addTimeAndConvert(String isoString) {
    try {
      // Parse the ISO 8601 string to a DateTime object
      DateTime dateTime = DateTime.parse(isoString);
      // Define the output format
      DateFormat formatter = DateFormat('hh:mm a');
      // Format the updated DateTime to a 12-hour format with AM/PM
      String formattedTime = formatter.format(dateTime.toLocal());
      return formattedTime;
    } catch (e) {
      return '-- --';
    }
  }

  /// Show a normal snackbar with a message
  static showInSnackBarNormal(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        closeIconColor: ColorClass.white,
        backgroundColor: Colors.blue,
        showCloseIcon: true,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(5),
        content: Text(
          message,
          style: TextStyleClass.poppins600TextStyle(16, ColorClass.white),
        )));
  }

  // static showToast(String message, BuildContext context) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: ColorClass.primaryColor,
  //       textColor: ColorClass.white,
  //       fontSize: 16.0
  //   );
  // }

  /// Convert Date "2023-11-17T18:30:00.000Z" into "11 Nov 2023"
  static String formatDate(String inputDateString) {
    // Parse the input string to DateTime
    try {
      DateTime dateTime = DateTime.parse(inputDateString);
      // Format the DateTime to "dd MMMM yyyy" using intl package
      String formattedDate = DateFormat("dd MMM yyyy").format(dateTime);
      return formattedDate;
    } catch (e) {
      return '';
    }
  }

  static String wfhPostDateFormat(String dateString) {
    DateFormat inputFormat = DateFormat("dd MMMM yyyy");
    DateFormat outputFormat = DateFormat("MM-dd-yyyy");

    DateTime date = inputFormat.parse(dateString);

    return outputFormat.format(date);
  }

  /// Convert Date "2023-11-17T18:30:00.000Z" into "2023-11-17"
  static String formatDateString(String originalDateString) {
    // Parse the original string into a DateTime object
    DateTime originalDate = DateTime.parse(originalDateString);
    // Format the DateTime object into the desired format
    String formattedDate = DateFormat('yyyy-MM-dd').format(originalDate);
    return formattedDate;
  }

  /// Convert Date "2023-11-17T18:30:00.000Z" into "Apr 18,Thur"
  static String formatWorkFromHomeDate(String originalDateString) {
    // Parse the original string into a DateTime object
    DateTime originalDate = DateTime.parse(originalDateString);
    // Format the DateTime object into the desired format
    String formattedDate = DateFormat("dd EEE").format(originalDate);
    return formattedDate;
  }

  static String dateConversionPostApi(String inputDateString) {
    try {
      // Parse the input string to DateTime
      DateTime dateTime = DateTime.parse(inputDateString);

      String convertedDate = DateFormat("yyyy-MM-dd").format(dateTime);
      return convertedDate;
    } catch (e) {
      return '';
    }
  }

  /// Convert Date todays data into "11 Nov 2023"
  static String todayDateYyyyMMdd() {
    DateTime now = DateTime.now();
    // Format the date
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return formattedDate;
  }

  static noDataFoundWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   ImageClass.noDataFoundImg,
          //   height: 100,
          // ),
          // const SizedBox(
          //   height: 10.0,
          // ),
          Text(
            "Oops!!",
            style: TextStyleClass.poppins300TextStyle(18, ColorClass.black),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            "No data found",
            style: TextStyleClass.poppins300TextStyle(12, ColorClass.grey),
          ),
        ],
      ),
    );
  }

  static noTextWidget() {
    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Text(
            "No data found",
            style: TextStyleClass.poppins300TextStyle(12, ColorClass.grey),
          ),
        ],
      ),
    );
  }

  static loadingWidget(BuildContext context, double? size) {
    return SizedBox(
        height: size,
        child: const Center(
            child: CupertinoActivityIndicator(
          radius: 10.0,
        )));
  }

  static loadingWidgetWhite(BuildContext context, double? size) {
    return SizedBox(
        height: size,
        child: const Center(
            child: CupertinoActivityIndicator(
          color: Colors.white,
        )));
  }

  static noImageAvailable() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset(
          //   IconClass.noData,
          //   height: 30.0,
          //   // color: ColorClass.paleGreen,
          // ),
          const SizedBox(
            height: 8.0,
          ),
          SizedBox(
            width: 60.0,
            child: Text(
              "No Image Found",
              textAlign: TextAlign.center,
              style: TextStyleClass.poppins700TextStyle(10, ColorClass.grey),
            ),
          ),
        ],
      ),
    );
  }

  static Color getPaymentStatusColor(String status) {
    switch (status) {
      case 'Paid':
        return Colors.blue;
      case 'UnPaid':
        return Colors.red;
      default:
        // Default color in case the status is neither "Pending" nor "Accepted"
        return Colors.grey;
    }
  }
}
