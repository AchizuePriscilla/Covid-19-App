import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scamp_assesment/core/viewmodels/scamp_vm.dart';

final scampVM = ChangeNotifierProvider((_) => ScampViewModel());
