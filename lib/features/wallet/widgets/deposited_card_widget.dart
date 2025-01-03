import 'package:flutter/material.dart';
import 'package:fashion24_deliveryman/common/basewidgets/custom_divider_widget.dart';
import 'package:fashion24_deliveryman/features/wallet/domain/models/deposited_model.dart';
import 'package:fashion24_deliveryman/helper/date_converter.dart';
import 'package:fashion24_deliveryman/helper/price_converter.dart';
import 'package:fashion24_deliveryman/utill/dimensions.dart';
import 'package:fashion24_deliveryman/utill/images.dart';
import 'package:fashion24_deliveryman/utill/styles.dart';

class DepositedCardWidget extends StatelessWidget {
  final Deposit deposit;
  const DepositedCardWidget({Key? key, required this.deposit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,
      Dimensions.paddingSizeSmall,Dimensions.paddingSizeDefault,Dimensions.paddingSizeSmall,),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

        Row(children: [
          Padding(padding:  EdgeInsets.only(right: Dimensions.paddingSizeDefault),
            child: SizedBox(width:Dimensions.iconSizeDefault,child: Image.asset(Images.depositedIcon))),

          Expanded(child: Text(DateConverter.isoStringToDateTimeString(deposit.updatedAt!).toString(),
            style: rubikRegular.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeSmall),)),
          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(.1)),
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),
            child: Text(' ${PriceConverter.convertPrice(deposit.credit)}',
                style: rubikMedium.copyWith(color: Theme.of(context).colorScheme.onTertiaryContainer)))]),


        Padding(padding:  EdgeInsets.only(top: Dimensions.paddingSizeSmall),
          child: CustomDividerWidget(height: .5,color: Theme.of(context).hintColor))]));
  }
}
