import 'package:flutter/material.dart';
import 'package:fashion24_deliveryman/features/language/domain/models/language_model.dart';
import 'package:fashion24_deliveryman/utill/app_constants.dart';

class LanguageRepository {
  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }
}
