import 'package:after_layout/after_layout.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:scamp_assesment/core/providers.dart';
import 'package:scamp_assesment/core/viewmodels/scamp_vm.dart';
import 'package:scamp_assesment/utils/margin.dart';
import 'package:scamp_assesment/utils/theme.dart';

class MyAppState extends StatefulHookWidget {
  @override
  _MyAppStateState createState() => _MyAppStateState();
}

class _MyAppStateState extends State<MyAppState> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    var provider = scampVM.read(context);
    provider.loadData();
  }

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(scampVM);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Column(
        children: [
          YMargin(20),
          Padding(
            padding: EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Covid 19",
                      style: GoogleFonts.montserrat(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Good Morning",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: grey,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
                Text(
                  "🌤️",
                  style: GoogleFonts.montserrat(
                    fontSize: 33,
                    color: grey,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
          YMargin(20),
          Container(
            height: 55,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(13)),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: Row(
                children: [
                  Icon(
                    LineIcons.search,
                    color: Colors.blueAccent,
                  ),
                  XMargin(10),
                  Expanded(
                    child: TextField(
                      onChanged: (v) => provider.search(v),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search country",
                        hintStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          YMargin(20),
          Flexible(
            child: ListView(
              children: [
                if (!provider.searching) GlobalSection(),
                if (!provider.searching) YMargin(30),
                Padding(
                  padding: EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Text(
                        "COUNTRIES",
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          color: Color(0xff433D57),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Filter By:  ",
                        style: GoogleFonts.montserrat(
                          fontSize: 9,
                          color: Color(0xff433D57),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      new DropdownButton<String>(
                        items: <String>['None', 'Cases', 'Death', 'Recovered']
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(
                              value,
                              style: GoogleFonts.montserrat(
                                fontSize: 9,
                                color: Color(0xff433D57),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          );
                        }).toList(),
                        value: provider.selectedFilter,
                        onChanged: (_) {
                          provider.selectedFilter = _;
                          provider.filter();
                        },
                      )
                    ],
                  ),
                ),
                YMargin(20),
                if (provider?.summaryModel != null)
                  for (var i = 0; i < provider.countryList?.length ?? 0; i++)
                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: i % 2 == 0 ? primary : white,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenWidth(context, percent: 0.3),
                            child: Text(
                              provider?.countryList[i].country ?? "",
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                color: i % 2 == 0 ? white : textColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          DashItem(
                            title: 'Confirmed Cases',
                            value: provider?.countryList[i].totalConfirmed,
                            isMini: true,
                            index: i,
                          ),
                          DashItem(
                            title: 'Deaths',
                            value: provider?.countryList[i].totalDeaths,
                            isMini: true,
                            index: i,
                          ),
                          DashItem(
                            title: 'Recovered',
                            value: provider?.countryList[i].totalRecovered,
                            isMini: true,
                            index: i,
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class GlobalSection extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var provider = useProvider(scampVM);
    return Container(
      height: screenHeight(context, percent: 0.25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "GLOBAL DATA",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Color(0xff1A1919),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const YMargin(4),
                  Text(
                    "${DateFormat('MMMM d y').format(provider?.summaryModel?.date != null ? DateTime.parse(provider?.summaryModel?.date) : DateTime.now())}",
                    style: GoogleFonts.montserrat(
                      fontSize: 9,
                      color: lightGrey,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DashItem(
                      value: provider?.summaryModel?.global?.totalConfirmed,
                      title: 'Total Confirmed Cases',
                    ),
                    YMargin(screenHeight(context, percent: 0.04)),
                    DashItem(
                      value: provider?.summaryModel?.global?.newConfirmed,
                      title: 'New Confirmed Cases',
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DashItem(
                      value: provider?.summaryModel?.global?.totalDeaths,
                      title: 'Total Deaths',
                    ),
                    YMargin(screenHeight(context, percent: 0.04)),
                    DashItem(
                      value: provider?.summaryModel?.global?.newDeaths,
                      title: 'New Deaths',
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DashItem(
                      value: provider?.summaryModel?.global?.totalRecovered,
                      title: 'Total Recovered',
                    ),
                    YMargin(screenHeight(context, percent: 0.04)),
                    DashItem(
                      value: provider?.summaryModel?.global?.newRecovered,
                      title: 'New Recovered',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashItem extends StatelessWidget {
  const DashItem({
    Key key,
    @required this.title,
    this.isMini = false,
    this.value,
    this.index,
  }) : super(key: key);

  final String title;
  final int value;
  final bool isMini;
  final index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          !isMini ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        /* Countup(
          begin: 0,
          end: (value ?? 0).ceilToDouble(),
          duration: Duration(seconds: 1),
          separator: ',',
          style: GoogleFonts.montserrat(
            fontSize: isMini ? 14 : 19,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ), */
        Container(
          width: isMini ? 30 : null,
          child: Text(
            "${NumberFormat("#,###").format(value ?? 0)}",
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontSize: isMini ? 12 : 15,
              color: index != null && index % 2 == 0 ? white : textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          title ?? "",
          style: GoogleFonts.montserrat(
            fontSize: isMini ? 8 : 7.5,
            color: index != null && index % 2 == 0 ? white : grey,
            fontWeight: isMini ? FontWeight.w300 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
