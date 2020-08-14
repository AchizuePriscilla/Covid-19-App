import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'url.dart';

class ScampApi {
  Future<Either<Exception, String>> getCovid19Data() async {
    try {
      final response = await http.get(APIUrl.summary);

      return Right(response.body);
    } catch (e) {
      return (Left(e));
    }
  }
}
