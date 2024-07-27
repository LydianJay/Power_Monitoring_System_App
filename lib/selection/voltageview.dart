import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VoltageView extends StatefulWidget {
  const VoltageView({super.key});

  @override
  State<VoltageView> createState() => _VoltageViewState();
}

class _VoltageViewState extends State<VoltageView> {
  List<double> voltageReadings = [];
  List<double> voltages = [];
  late Timer timer;
  Future<Widget> getDataFromDB(double scrWidth, double scrHeight) async {
    debugPrint('On Display!!!');

    await fetchData();

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: SfCartesianChart(
        title: const ChartTitle(text: 'Voltage'),
        series: <LineSeries<double, int>>[
          LineSeries<double, int>(
            dataSource: voltages,
            xValueMapper: (d, i) {
              return i;
            },
            yValueMapper: (d, i) {
              return d;
            },
          ),
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    debugPrint('Fetching data...');

    final future = await Supabase.instance.client
        .from('Reading')
        .select('voltage')
        .order('id', ascending: true);

    voltages = [];

    debugPrint("Data Fetched! ${future.length} Content: ${future.toString()}");
    debugPrint('List content: ${voltages.length}');
    for (var v in future) {
      debugPrint('Votages: ${v['voltage']}');
      voltages.add(double.parse(v['voltage'].toString()));
    }
    debugPrint('List content: ${voltages.length}');
  }

  @override
  void initState() {
    super.initState();
    debugPrint('Init state!');
    // fetchData();
    // setState(() {});

    // fetchData();
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;
    return Container(
      width: scrWidth * 0.65,
      height: scrHeight * 0.90,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black, blurRadius: 1.2, spreadRadius: 0.5),
        ],
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FutureBuilder(
        future: getDataFromDB(scrWidth, scrHeight),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          debugPrint('Refreshing Voltage DIsplay');
          return snapshot.requireData;
        },
      ),
    );
  }
}
