import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fashion24_deliveryman/features/wallet/controllers/wallet_controller.dart';
import 'package:fashion24_deliveryman/common/basewidgets/custom_loader_widget.dart';
import 'package:fashion24_deliveryman/common/basewidgets/no_data_screen_widget.dart';
import 'package:fashion24_deliveryman/features/wallet/widgets/transaction_card_widget.dart';

class TransactionListViewWidget extends StatelessWidget {
  const TransactionListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      builder: (walletController) {
        return !walletController.isLoading? walletController.deliveryWiseEarned.isNotEmpty?
        ListView.builder(
          itemCount: walletController.deliveryWiseEarned.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (transactionContext, transactionIndex)=>
                TransactionCardWidget(orders: walletController.deliveryWiseEarned[transactionIndex])):
        const NoDataScreenWidget(): CustomLoaderWidget(height: Get.height-600,);
      }
    );
  }
}
