import 'package:covid_app/Services/Accessing_Stats_Serrvice.dart';
import 'package:covid_app/Views/CountryDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Countries_list_Screen extends StatefulWidget {
  const Countries_list_Screen({Key? key}) : super(key: key);

  @override
  State<Countries_list_Screen> createState() => _Countries_list_ScreenState();
}

class _Countries_list_ScreenState extends State<Countries_list_Screen> {
  StatsService statsService = StatsService();

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 25, 27),
      appBar: AppBar(
        //just for the back screen arrow, app bar is used
        backgroundColor: Color.fromARGB(255, 26, 25, 27),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                      hintText: "Country name here",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 25))),
            ),
            Expanded(
              child: FutureBuilder(
                  future: statsService.getCountriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                  title: Container(
                                    height: 10,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String countryName =
                                snapshot.data![index]["country"];

                            if (_controller.text.isEmpty) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CountryDetailScreen(
                                                      country: snapshot.data![index]["country"],
                                                      continent: snapshot.data![index]["continent"],
                                                      flagUrl: snapshot.data![index]["countryInfo"]["flag"],
                                                      population: snapshot.data![index]["population"],
                                                      tests: snapshot.data![index]["tests"],
                                                      cases: snapshot.data![index]["cases"],
                                                      active: snapshot.data![index]["active"],
                                                      recovered: snapshot.data![index]["recovered"],
                                                      deaths: snapshot.data![index]["deaths"]
                                                  )
                                          )
                                      );
                                    },

                                    child: ListTile(
                                      title: Text(
                                        snapshot.data![index]["country"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          "Cases: " +
                                              snapshot.data![index]["cases"]
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                      leading: Image(
                                        image: NetworkImage(
                                            snapshot.data![index]["countryInfo"]
                                                ["flag"]),
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else if (countryName
                                .toLowerCase()
                                .contains(_controller.text.toLowerCase())) {
                              // print(countryName);

                              return Expanded(
                                child: Column(
                                  children: [
                                    GestureDetector(

                                      onTap: () {

                                        FocusScope.of(context).unfocus();

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CountryDetailScreen(
                                                        country: snapshot.data![index]["country"],
                                                        continent: snapshot.data![index]["continent"],
                                                        flagUrl: snapshot.data![index]["countryInfo"]["flag"],
                                                        population: snapshot.data![index]["population"],
                                                        tests: snapshot.data![index]["tests"],
                                                        cases: snapshot.data![index]["cases"],
                                                        active: snapshot.data![index]["active"],
                                                        recovered: snapshot.data![index]["recovered"],
                                                        deaths: snapshot.data![index]["deaths"]
                                                    )
                                            )
                                        );
                                      },

                                      child: ListTile(
                                        title: Text(
                                          snapshot.data![index]["country"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            "Cases: " +
                                                snapshot.data![index]["cases"]
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16),
                                          ),
                                        ),
                                        leading: Image(
                                          image: NetworkImage(snapshot.data![index]
                                              ["countryInfo"]["flag"]),
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
