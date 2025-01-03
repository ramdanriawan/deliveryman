import 'package:get/get_connect/http/src/response/response.dart';
import 'package:fashion24_deliveryman/data/api/api_checker.dart';
import 'package:fashion24_deliveryman/features/onboard/domain/models/onboarding_model.dart';
import 'package:fashion24_deliveryman/features/onboard/domain/repositories/onbording_repository_interface.dart';
import 'package:fashion24_deliveryman/features/onboard/domain/services/onboard_service_interface.dart';

class OnboardService implements OnboardServiceInterface{
  OnboardRepositoryInterface onboardRepoInterface;
  OnboardService({required this.onboardRepoInterface});

  @override
  Future getOnBoardingList() async {
    Response response = await onboardRepoInterface.getList();
    List<OnBoardingModel> _onBoardingList = [];
   if (response.statusCode == 200) {
     _onBoardingList = [];
     _onBoardingList.addAll(response.body);
   } else {
     ApiChecker.checkApi(response);
   }
   return _onBoardingList;
  }
}