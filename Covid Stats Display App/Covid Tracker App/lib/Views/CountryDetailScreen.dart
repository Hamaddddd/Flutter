import 'package:covid_app/Views/Overall_Stats_Screen.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatefulWidget {
  String country, continent, flagUrl;

  int population, tests, cases, active, recovered, deaths;

  CountryDetailScreen(
      {required this.country,
      required this.continent,
      required this.flagUrl,
      required this.population,
      required this.tests,
      required this.cases,
      required this.active,
      required this.recovered,
      required this.deaths});

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 26, 25, 27),
        appBar: AppBar(
          title: Text(widget.country),
          backgroundColor: Color.fromARGB(255, 51, 50, 51),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [

            SizedBox(height: MediaQuery.of(context).size.height * .03,),

            Stack(

              children: [

                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .3),
                  child: Card(
                    color: Color.fromARGB(255, 51, 50, 51),

                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .04,),

                        ReuseableRow(title: "Continent", value: widget.continent),
                        ReuseableRow(title: "Population", value: widget.population.toString()),
                        ReuseableRow(title: "Tests Done", value: widget.tests.toString()),
                        ReuseableRow(title: "Total Cases", value: widget.cases.toString()),
                        ReuseableRow(title: "Active", value: widget.active.toString()),
                        ReuseableRow(title: "Recovered", value: widget.recovered.toString()),
                        ReuseableRow(title: "Deaths", value: widget.deaths.toString()),

                      ],
                    ),
                  ),
                ),


                Center(
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: NetworkImage(widget.flagUrl),
                  ),
                ),


              ],
            ),






          ],
        ),
      ),
    );
  }
}
