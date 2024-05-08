import 'package:flutter/material.dart';
import 'package:power_monitoring_system/selection/allreadingsview.dart';
import 'package:power_monitoring_system/selection/voltageview.dart';
import 'package:sidebarx/sidebarx.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  Widget renderWidget(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const AllReadingsView();
      case 1:
        return const VoltageView();
    }

    return Text('$selectedIndex');
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: SidebarX(
              showToggleButton: false,
              controller: _controller,
              extendedTheme: SidebarXTheme(
                width: scrWidth * 0.23,
                itemTextPadding: const EdgeInsets.only(left: 10),
                selectedItemTextPadding: const EdgeInsets.only(left: 10),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Calibre',
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: const IconThemeData(color: Colors.white),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  border:
                      BorderDirectional(end: BorderSide(color: Colors.white)),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                selectedItemDecoration: const BoxDecoration(
                    color: Color.fromARGB(255, 117, 193, 255)),
                hoverColor: const Color.fromARGB(255, 117, 193, 255),
                hoverTextStyle:
                    const TextStyle(color: Color.fromARGB(255, 117, 193, 255)),
              ),
              headerBuilder: (context, extended) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        'Control Panel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
              footerBuilder: (context, extended) {
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Text(
                        'Created by: SNSU Students',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: extended ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
              items: const [
                SidebarXItem(
                  icon: Icons.gas_meter,
                  label: 'Readings',
                ),
                SidebarXItem(
                  icon: Icons.electric_bolt,
                  label: 'Voltage Graph Reading',
                ),
                SidebarXItem(
                  icon: Icons.electrical_services,
                  label: 'Current Graph Reading',
                ),
                SidebarXItem(
                  icon: Icons.electric_meter_outlined,
                  label: 'Power Graph Reading',
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Expanded(
                child: Container(
                  height: scrHeight,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: renderWidget(_controller.selectedIndex),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
