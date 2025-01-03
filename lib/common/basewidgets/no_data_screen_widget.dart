import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fashion24_deliveryman/utill/dimensions.dart';
import 'package:fashion24_deliveryman/utill/images.dart';
import 'package:fashion24_deliveryman/utill/styles.dart';


class NoDataScreenWidget extends StatelessWidget {
  const NoDataScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding:  EdgeInsets.all(Dimensions.paddingSizeLarge),
      child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, children: [
              Image.asset(Images.noDataFound, width: 150, height: 150),
          Text('no_data_found'.tr,
            style: rubikRegular.copyWith(color: Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                fontSize: MediaQuery.of(context).size.height * 0.023),
            textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}
