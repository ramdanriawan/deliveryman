import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fashion24_deliveryman/features/profile/controllers/profile_controller.dart';
import 'package:fashion24_deliveryman/helper/price_converter.dart';
import 'package:fashion24_deliveryman/utill/dimensions.dart';
import 'package:fashion24_deliveryman/utill/styles.dart';
import 'package:fashion24_deliveryman/features/wallet/screens/wallet_screen.dart';


class BalanceWithdrawWidget extends StatelessWidget {
  final ProfileController? profileController;
  const BalanceWithdrawWidget({Key? key, this.profileController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(padding:  EdgeInsets.all(Dimensions.paddingSizeLarge),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          color: Theme.of(context).primaryColor.withOpacity(.05)),
      child: Row(children: [
        Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
            Text(PriceConverter.convertPrice(profileController?.profileModel?.withdrawableBalance),
                style: rubikMedium.copyWith(color: Theme.of(context).primaryColorLight, fontSize: Dimensions.fontSizeExtraLarge)),
             SizedBox(height: Dimensions.paddingSizeDefault),
            Text('withdrawable_balance'.tr,style: rubikRegular.copyWith(color: Theme.of(context).primaryColorLight))])),
        InkWell(onTap: ()=> Get.to(const WalletScreen(fromNotification: true)),
          child: Icon(CupertinoIcons.arrow_right, size:Dimensions.iconSizeLarge,
              color: Theme.of(context).cardColor.withOpacity(.65)))
      ],),);
  }
}
