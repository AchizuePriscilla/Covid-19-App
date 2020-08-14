import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:scamp_assesment/core/models/glitch/glitch.dart';
import 'package:scamp_assesment/core/models/glitch/no_internet_glitch.dart';
import 'package:scamp_assesment/core/models/scamp_model.dart';
import 'package:scamp_assesment/core/service/scamp_api.dart';

class ScampHelper {
  final api = ScampApi();
  Future<Either<Glitch, SummaryModel>> getCovid19Data() async {
    final apiResult = await api.getCovid19Data();

    return (await fold(apiResult)).fold(
      (l) => Left(l),
      (r) {
        print(r);
        return Right(SummaryModel.fromJson(json.decode(r)));
      },
    );
  }

  FutureOr<Either<Glitch, String>> fold(Either<Exception, String> apiResult) {
    return apiResult.fold((l) {
      print(l.toString());
      return Left(NoInternetGlitch());
    }, (r) {
      return Right(r);
    });
  }
}
