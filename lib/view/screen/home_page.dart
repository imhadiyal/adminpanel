import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../components/chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class _HomePageState extends State<HomePage> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    data = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Admin Panel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.3,
              width: size.width * 0.9,
              child: LayoutBuilder(
                builder: (context, constraints) => LineChart(
                  showAvg ? mainData() : avgData(),
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              child: LayoutBuilder(
                builder: (context, constraints) => SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  primaryYAxis:
                      const NumericAxis(minimum: 0, maximum: 40, interval: 10),
                  tooltipBehavior: _tooltip,
                  series: <CartesianSeries<_ChartData, String>>[
                    ColumnSeries<_ChartData, String>(
                        dataSource: data,
                        xValueMapper: (_ChartData data, _) => data.x,
                        yValueMapper: (_ChartData data, _) => data.y,
                        name: 'Gold',
                        color: const Color.fromRGBO(8, 142, 255, 1))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
