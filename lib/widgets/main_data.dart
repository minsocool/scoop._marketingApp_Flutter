import 'package:app_marketing_version_2/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MainData extends StatelessWidget {
  final List<Color> _gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  final double valueMan;
  final double valueWoman;
  final String? titleMan;
  final String? titleWoman;
  final List<dynamic>? age;
  final int list;
  final double? offSetMan;
  final double? offSetWoman;
  MainData(
      {this.valueMan = 0,
      this.valueWoman = 0,
      this.titleMan,
      this.titleWoman,
      this.age,
      this.list = 2,
      this.offSetMan = 0.5,
      this.offSetWoman = 0.5});
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double _aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: _aspectRatio * 2.5,
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    startDegreeOffset: 90,
                    sections: showingSections(
                      offSetMan: offSetMan,
                      offSetWoman: offSetWoman,
                      list: list,
                      valueMan: valueMan,
                      valueWoman: valueWoman,
                      titleMan: titleMan,
                      titleWoman: titleWoman,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                note('Man', _width * 0.04, _height * 0.02, manColor),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: _height * 0.01),
                  child:
                      note('Woman', _width * 0.04, _height * 0.02, womanColor),
                ),
                note('No data', _width * 0.04, _height * 0.02, noDataColor),
              ],
            )
          ],
        ),
        AspectRatio(
          aspectRatio: _aspectRatio * 2.5,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xff232d37)),
            child: Padding(
              padding: EdgeInsets.only(
                right: _width * 0.05,
                top: _height * 0.02,
              ),
              child: LineChart(
                mainData(age: age),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData({List? age}) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
            }
            return '';
          },
          margin: 0,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1:
                return '10';
              case 2:
                return '20';
              case 3:
                return '30';
              case 4:
                return '40';
              case 5:
                return '50';
              case 6:
                return '60';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: age!.length.toDouble() - 1,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: age
              .asMap()
              .map((key, value) =>
                  MapEntry(key, FlSpot(key.toDouble(), value / 10)))
              .values
              .toList(),
          isCurved: true,
          colors: _gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                _gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections(
      {double? valueMan,
      double? valueWoman,
      double? offSetMan,
      double? offSetWoman,
      String? titleMan,
      int? list,
      String? titleWoman}) {
    return List.generate(list!, (i) {
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: manColor,
            value: valueMan,
            title: titleMan,
            titlePositionPercentageOffset: offSetMan,
            radius: 100,
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );

        case 1:
          return PieChartSectionData(
            color: womanColor,
            value: valueWoman,
            title: titleWoman,
            titlePositionPercentageOffset: offSetWoman,
            radius: 100,
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );

        default:
          return PieChartSectionData(
            color: Colors.red[800],
            value: 100,
            title: 'Something went wrong',
            radius: 100,
            titlePositionPercentageOffset: 0,
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
      }
    });
  }

  Widget note(String label, double width, double height, Color? color) {
    return Row(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle, // : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(
          width: width / 2,
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        )
      ],
    );
  }
}
