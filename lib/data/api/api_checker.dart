
import 'package:get/get.dart';
import 'package:fashion24_deliveryman/features/splash/controllers/splash_controller.dart';
import 'package:fashion24_deliveryman/common/basewidgets/custom_snackbar_widget.dart';
import 'package:fashion24_deliveryman/features/auth/screens/login_screen.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<SplashController>().removeSharedData();
      Get.to(() => const LoginScreen());
    }else {
      showCustomSnackBarWidget(response.statusText);
    }
  }
}