import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AllReadingsView extends StatefulWidget {
  const AllReadingsView({
    super.key,
  });

  @override
  State<AllReadingsView> createState() => _AllReadingsViewState();
}

class _AllReadingsViewState extends State<AllReadingsView> {
  double voltage = 240.2, power = 1200.1, current = 1.2, pf = 2.0;
  Timer? timer;

  Future<Widget> getDataFromDB(double scrWidth, double scrHeight) async {
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
      child: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SfRadialGauge(
                        axes: [
                          RadialAxis(
                            minimum: 0,
                            maximum: 600,
                            ranges: [
                              GaugeRange(
                                startValue: 0,
                                endValue: 210,
                                color: const Color.fromARGB(255, 0, 195, 255),
                                label: 'Low Voltage',
                              ),
                              GaugeRange(
                                startValue: 211,
                                endValue: 240,
                                color: const Color.fromARGB(255, 0, 255, 0),
                                label: '',
                              ),
                              GaugeRange(
                                startValue: 241,
                                endValue: 250,
                                color: const Color.fromARGB(255, 229, 255, 0),
                                label: '',
                              ),
                              GaugeRange(
                                startValue: 251,
                                endValue: 600,
                                color: const Color.fromARGB(255, 255, 0, 0),
                                label: 'Critical',
                              ),
                            ],
                            pointers: [
                              NeedlePointer(
                                value: voltage,
                                enableAnimation: true,
                              ),
                            ],
                            annotations: [
                              GaugeAnnotation(
                                widget: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 175, 0, 0),
                                  child: Text(
                                    'Voltage: ${voltage.toStringAsFixed(1)}',
                                    style: const TextStyle(
                                      fontFamily: 'Calibre',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                angle: 180.0 * (voltage / 180.0),
                                positionFactor: 0,
                              )
                            ],
                          ),
                        ],
                      ),
                      SfRadialGauge(
                        axes: [
                          RadialAxis(
                            minimum: 0,
                            maximum: 60,
                            ranges: [
                              GaugeRange(
                                startValue: 0,
                                endValue: 20,
                                color: const Color.fromARGB(255, 0, 255, 0),
                                label: '',
                              ),
                              GaugeRange(
                                startValue: 20,
                                endValue: 40,
                                color: const Color.fromARGB(255, 229, 255, 0),
                                label: '',
                              ),
                              GaugeRange(
                                startValue: 40,
                                endValue: 60,
                                color: const Color.fromARGB(255, 255, 0, 0),
                                label: '',
                              ),
                            ],
                            pointers: [
                              NeedlePointer(
                                value: current,
                                enableAnimation: true,
                              ),
                            ],
                            annotations: [
                              GaugeAnnotation(
                                widget: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 175, 0, 0),
                                  child: Text(
                                    'Current: ${current.toStringAsFixed(1)}A',
                                    style: const TextStyle(
                                      fontFamily: 'Calibre',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                angle: 180.0 * (voltage / 180.0),
                                positionFactor: 0,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SfRadialGauge(
                        axes: [
                          RadialAxis(
                            minimum: 0,
                            maximum: 16000,
                            ranges: [
                              GaugeRange(
                                startValue: 0,
                                endValue: 1000,
                                color: const Color.fromARGB(255, 0, 195, 255),
                                label: '',
                              ),
                              GaugeRange(
                                startValue: 1000,
                                endValue: 6000,
                                color: const Color.fromARGB(255, 0, 255, 0),
                                label: '',
                              ),
                              GaugeRange(
                                startValue: 6000,
                                endValue: 12000,
                                color: const Color.fromARGB(255, 229, 255, 0),
                                label: '',
                              ),
                              GaugeRange(
                                startValue: 12000,
                                endValue: 16000,
                                color: const Color.fromARGB(255, 255, 0, 0),
                                label: '',
                              ),
                            ],
                            pointers: [
                              NeedlePointer(
                                value: power,
                                enableAnimation: true,
                              ),
                            ],
                            annotations: [
                              GaugeAnnotation(
                                widget: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 175, 0, 0),
                                  child: Text(
                                    'Power: ${power.toStringAsFixed(1)}Watts',
                                    style: const TextStyle(
                                      fontFamily: 'Calibre',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                angle: 180.0 * (voltage / 180.0),
                                positionFactor: 0,
                              )
                            ],
                          ),
                        ],
                      ),
                      SfRadialGauge(
                        axes: [
                          RadialAxis(
                            minimum: 0,
                            maximum: 60,
                            ranges: [
                              GaugeRange(
                                startValue: 0,
                                endValue: 20,
                                color: const Color.fromARGB(255, 0, 255, 0),
                                label: '',
                              ),
                              GaugeRange(
                                startValue: 20,
                                endValue: 40,
                                color: const Color.fromARGB(255, 229, 255, 0),
                                label: '',
                              ),
                              GaugeRange(
                                startValue: 40,
                                endValue: 60,
                                color: const Color.fromARGB(255, 255, 0, 0),
                                label: '',
                              ),
                            ],
                            pointers: [
                              NeedlePointer(
                                value: current,
                                enableAnimation: true,
                              ),
                            ],
                            annotations: [
                              GaugeAnnotation(
                                widget: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 175, 0, 0),
                                  child: Text(
                                    'Power Factor: ${pf.toStringAsFixed(1)}',
                                    style: const TextStyle(
                                      fontFamily: 'Calibre',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                angle: 180.0 * (voltage / 180.0),
                                positionFactor: 0,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void fetchData() async {
    debugPrint('Fetching data...');
    final future = await Supabase.instance.client
        .from('Reading')
        .select()
        .order('id')
        .limit(1)
        .single();
    //final future = await Supabase.instance.client.from('Readings').select();

    debugPrint('Contains: ${future.toString()}');

    voltage = double.parse(future['voltage'].toString());
    power = double.parse(future['power'].toString());
    current = double.parse(future['current'].toString());
    pf = double.parse(future['power_factor'].toString());

    debugPrint('Data Set!');
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: getDataFromDB(scrWidth, scrHeight),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return snapshot.requireData;
      },
    );
  }
}
