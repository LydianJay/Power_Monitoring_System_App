import 'package:flutter/material.dart';

class VoltageView extends StatefulWidget {
  const VoltageView({super.key});

  @override
  State<VoltageView> createState() => _VoltageViewState();
}

class _VoltageViewState extends State<VoltageView> {
  List<double> voltageReadings = [];

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
    );
  }
}
