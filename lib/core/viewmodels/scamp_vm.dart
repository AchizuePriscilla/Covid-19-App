import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scamp_assesment/core/helper/scamp_helper.dart';
import 'package:scamp_assesment/core/models/glitch/no_internet_glitch.dart';
import 'package:scamp_assesment/core/models/scamp_model.dart';

class ScampViewModel extends ChangeNotifier {
  SummaryModel _summaryModel;
  SummaryModel get summaryModel => _summaryModel;

  String _selectedFilter;
  String get selectedFilter => _selectedFilter;

  List<Countries> _filteredList = [];
  List<Countries> get filteredList => _filteredList;

  bool _searching = false;
  bool get searching => _searching;

  List<Countries> get countryList =>
      !searching ? summaryModel?.countries : filteredList;

  set searching(bool val) {
    _searching = val;
    notifyListeners();
  }

  set filteredList(List<Countries> val) {
    _filteredList = val;
    notifyListeners();
  }

  set selectedFilter(String val) {
    _selectedFilter = val;
    notifyListeners();
  }

  set summaryModel(SummaryModel val) {
    _summaryModel = val;
    notifyListeners();
  }

  Future<void> loadData() async {
    final covid19data = await ScampHelper().getCovid19Data();
    covid19data.fold((l) {
      if (l is NoInternetGlitch) {
        print(l.toString());
      }
    }, (r) {
      summaryModel = r;
    });
    notifyListeners();
  }

  filter() {
    List<Countries> tempList = _summaryModel?.countries ?? [];

    if (tempList.length > 0)
      switch (_selectedFilter) {
        case 'Cases':
          tempList.sort((a, b) => a.totalConfirmed.compareTo(b.totalConfirmed));
          break;
        case 'Death':
          tempList.sort((a, b) => a.totalDeaths.compareTo(b.totalDeaths));
          break;
        case 'Recovered':
          tempList.sort((a, b) => a.totalRecovered.compareTo(b.totalRecovered));
          break;
        default:
          tempList.sort((a, b) => a.country.compareTo(b.country));
          tempList = tempList.reversed.toList();
          break;
      }
    tempList = tempList.reversed.toList();

    summaryModel.countries = tempList.toList();
  }

  void search(String value) {
    try {
      List<Countries> tempList = _summaryModel?.countries ?? [];
      if (value != null && value.isNotEmpty) {
        filteredList = tempList
            .where((e) => e.country.toLowerCase().contains(value.toLowerCase()))
            .toList();

        searching = true;
      } else {
        searching = false;
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
