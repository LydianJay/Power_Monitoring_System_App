import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PowerReadingsView extends StatefulWidget {
  const PowerReadingsView({super.key});

  @override
  State<PowerReadingsView> createState() => _PowerReadingsViewState();
}

class _PowerReadingsViewState extends State<PowerReadingsView> {
  List<double> voltageReadings = [];

  Future<Widget> getDataFromDB(double scrWidth, double scrHeight) async {
    debugPrint('Fetching data...');
    final future = await Supabase.instance.client
        .from('Reading')
        .select('power')
        .order('id', ascending: true);

    List<double> current = [];

    debugPrint("Data Fetched! ${future.length} Content: ${future.toString()}");
    debugPrint('List content: ${current.length}');
    for (var v in future) {
      debugPrint('power: ${v['power']}');
      current.add(double.parse(v['power'].toString()));
    }
    debugPrint('List content: ${current.length}');

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: SfCartesianChart(
        title: const ChartTitle(text: 'Power (Watts)'),
        series: <LineSeries<double, int>>[
          LineSeries<double, int>(
            dataSource: current,
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
          return snapshot.requireData;
        },
      ),
    );
  }
}
