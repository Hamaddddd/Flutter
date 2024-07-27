import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Whatsapp"),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Icon(Icons.camera_alt_rounded),
              ),
              Tab(
                child: Text("Chats"),
              ),
              Tab(
                child: Text("Status"),
              ),
              Tab(
                child: Text("Calls"),
              )
            ],
          ),
          actions: [
            Icon(
              Icons.search,
            ),
            SizedBox(
              width: 10,
            ),
            PopupMenuButton(
              icon: Icon(Icons.more_vert_outlined),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("Theme"),
                  onTap: () {
                    print('"theme tapped"');
                  },
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text("Settings"),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text("Account"),
                ),
                PopupMenuItem(
                  value: 4,
                  child: Text("FM Mods"),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: TabBarView(children: [
          Text("Icon camera"),
          ListView.builder(
            itemCount: 15,
              itemBuilder: (context,index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage("https://picsum.photos/536/354"
                  ),
                ),
                title: Text("Hamad Ahmed"),
                subtitle: Text("I am building the Whatsapp UI"),
                trailing: Text("3:27"),
              );
          }
          ),
          ListView.builder(
              itemCount: 15,
              itemBuilder: (context,index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text("Recent Updates"),
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.teal.shade400,
                              width: 4
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage("https://picsum.photos/536/354"
                            ),
                          ),
                        ),
                        // title: Text("Call "+ "$index"),
                        title: Text("Status Person "+ "$index"),
                        // subtitle: Align(alignment: Alignment.bottomLeft, child: Icon(Icons.add_ic_call_outlined),),
                        subtitle: Text(index % 2 == 0 ? "20 minutes ago": "Today, 10:47 PM"),
                      ),
                    ],
                  ),
                );
              }
          ),

          ListView.builder(
              itemCount: 15,
              itemBuilder: (context,index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("https://picsum.photos/536/354"
                    ),
                  ),
                  // title: Text("Call "+ "$index"),
                  title: Text("Hamad Ahmed"),
                  // subtitle: Align(alignment: Alignment.bottomLeft, child: Icon(Icons.add_ic_call_outlined),),
                  subtitle: Text(index / 2 == 0 ? "Missed an audio call at 4:31": "Call ended after 43 minutes"),
                  trailing: Icon(index / 2 ==0 ? Icons.phone_missed_rounded : Icons.videocam_rounded),
                );
              }
          ),
        ]),
      ),
    );
  }
}
