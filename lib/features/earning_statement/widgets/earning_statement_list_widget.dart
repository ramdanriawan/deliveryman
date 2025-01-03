import 'package:flutter/material.dart';
import 'package:fashion24_deliveryman/common/basewidgets/custom_loader_widget.dart';
import 'package:fashion24_deliveryman/features/wallet/controllers/wallet_controller.dart';
import 'package:fashion24_deliveryman/common/basewidgets/no_data_screen_widget.dart';
import 'package:fashion24_deliveryman/features/earning_statement/widgets/earning_statement_card_widget.dart';

class EarningStatementListViewWidget extends StatelessWidget {
  final WalletController? walletController;
  const EarningStatementListViewWidget({Key? key, this.walletController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      !walletController!.isLoading? walletController!.deliveryWiseEarned.isNotEmpty?
      ListView.builder(
        itemCount: walletController!.deliveryWiseEarned.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index)=> EarningStatementCardWidget(ordersWiseEarned: walletController!.deliveryWiseEarned[index])) :
      const NoDataScreenWidget() : const CustomLoaderWidget(height: 500,)
    ],);
  }
}
