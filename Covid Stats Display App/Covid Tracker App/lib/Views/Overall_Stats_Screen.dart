import 'package:covid_app/Models/WorldStats_Model.dart';
import 'package:covid_app/Services/Accessing_Stats_Serrvice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'Countries_List_Screen.dart';

class Overall_Stats_Screen extends StatefulWidget {
  const Overall_Stats_Screen({Key? key}) : super(key: key);

  @override
  State<Overall_Stats_Screen> createState() => _Overall_Stats_ScreenState();
}

class _Overall_Stats_ScreenState extends State<Overall_Stats_Screen>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3));

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246)
  ];

  StatsService statsService = StatsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 25, 27),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            FutureBuilder(
                future: statsService.getWorldStats(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {

                  if(!snapshot.hasData){

                    return Expanded(
                      flex: 1,
                      child: Center(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          controller: controller,
                        ),
                      ),
                    );


                  } else{

                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                            double.parse(snapshot.data!.cases.toString()),
                            "Recovered":
                            double.parse(snapshot.data!.recovered.toString()),
                            "Deaths":
                            double.parse(snapshot.data!.deaths.toString())
                          },
                          chartType: ChartType.ring,
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesOutside: false,
                              showChartValuesInPercentage: true,
                              showChartValues: true),
                          animationDuration: Duration(milliseconds: 1200),
                          chartRadius: MediaQuery.of(context).size.width * .4,
                          colorList: colorList,
                          legendOptions: LegendOptions(
                            legendTextStyle: TextStyle(
                              color: Colors.white,
                            ),
                            legendPosition: LegendPosition.right,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        Card(
                          color: Color.fromARGB(255, 51, 50, 51),
                          child: Column(
                            children: [
                              ReuseableRow(
                                  title: "Total",
                                  value: snapshot.data!.cases.toString()),
                              ReuseableRow(
                                  title: "Recovered",
                                  value: snapshot.data!.recovered.toString()),
                              ReuseableRow(
                                  title: "Deaths",
                                  value: snapshot.data!.deaths.toString()),
                              ReuseableRow(
                                  title: "Active",
                                  value: snapshot.data!.active.toString()),
                              ReuseableRow(
                                  title: "Critical",
                                  value: snapshot.data!.critical.toString()),
                              ReuseableRow(
                                  title: "Today Cases",
                                  value: snapshot.data!.todayCases.toString()),
                              ReuseableRow(
                                  title: "Today Recovered",
                                  value:
                                  snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Countries_list_Screen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Center(
                                child: Text(
                                  "Country Wise Ratio",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    );

                  }

                }),

          ],
        ),
      )),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;

  ReuseableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
