import 'dart:async';
import 'package:adobe_xd/adobe_xd.dart';
import 'package:coocoobird_design/Mainscreen/lightbluewidgets/Fontbuild.dart';
import 'package:coocoobird_design/Mainscreen/lightbluewidgets/build.dart';
import 'package:coocoobird_design/Mainscreen/DrawerScreen/screenDrawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'DrawerScreen/Performance.dart';

class xd_Mainscreen extends StatefulWidget {
  const xd_Mainscreen({Key? key}) : super(key: key);

  @override
  _xd_MainscreenState createState() => _xd_MainscreenState();
}

class _xd_MainscreenState extends State<xd_Mainscreen>
    with TickerProviderStateMixin {
  get child => null;

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      drawer: NavigationDrawer(),
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: const Text(
            'Welcome to Cocobird',
            style: TextStyle(fontSize: 23),
          ),
          backgroundColor: Colors.transparent,
          floating: true,

          // actions: [IconButton(onPressed: (){}, icon: Icons.menu)],
          expandedHeight: 50,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.only(left: 310.0),
              child: Image.asset('assets/images/coocoobird.png'),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // blueWigetBuild(context, 500, 400)

                  SvgPicture.string(
                    '<svg viewBox="0 0 1 1" ><path transform="matrix(0.559193, 0.829038, -0.829038, 0.559193, 915.04, 1793.59)" d="M -1716.925048828125 -139.1268157958984 C -1705.144287109375 -135.4883575439453 -1692.734619140625 -132.7277679443359 -1679.796630859375 -130.9619903564453 C -1576.888427734375 -116.9133453369141 -1476.194091796875 -173.5345001220703 -1458.724853515625 -255.2808074951172 C -1457.545166015625 -260.7998657226562 -1456.756591796875 -266.2999267578125 -1456.342529296875 -271.7622680664062 C -1452.968505859375 -316.3251342773438 -1433.486083984375 -359.3901977539062 -1397.647705078125 -393.7869262695312 C -1381.766357421875 -409.0310668945312 -1370.501708984375 -427.650390625 -1365.879638671875 -448.50634765625 C -1351.803466796875 -512.0192260742188 -1407.170654296875 -574.4986572265625 -1487.214111328125 -585.4000244140625 C -1498.202880859375 -586.8963012695312 -1509.115478515625 -587.39404296875 -1519.803955078125 -586.9762573242188 C -1568.197509765625 -585.084716796875 -1615.020263671875 -599.6085205078125 -1650.039306640625 -626.1972045898438 C -1676.671630859375 -646.4176635742188 -1710.783447265625 -660.8701782226562 -1749.649658203125 -666.5047607421875 C -1825.456787109375 -677.4947509765625 -1918.763427734375 -647.7525024414062 -1959.491455078125 -585.988525390625 C -1988.829345703125 -541.497802734375 -2033.892822265625 -504.5927124023438 -2090.491943359375 -482.1808471679688 C -2148.727783203125 -459.1215209960938 -2192.863037109375 -415.1821899414062 -2204.966064453125 -360.4620361328125 C -2224.587158203125 -271.7637329101562 -2148.203857421875 -183.2434844970703 -2036.915771484375 -165.9008026123047 C -2012.966064453125 -162.1680145263672 -1989.216552734375 -161.7799224853516 -1966.411376953125 -164.3166656494141 C -1882.020263671875 -173.7030181884766 -1796.343017578125 -163.6569366455078 -1716.925048828125 -139.1268157958984 Z" fill="#2971a7" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.559193, 0.829038, -0.829038, 0.559193, 1049.7, 2062.08)" d="M -2032.15771484375 -429.8864440917969 C -2027.938720703125 -428.2454833984375 -2023.494384765625 -427.0004272460938 -2018.860961914062 -426.2040405273438 C -1982.006225585938 -419.8680114746094 -1945.944580078125 -445.404541015625 -1939.688232421875 -482.272705078125 C -1939.265747070312 -484.7618408203125 -1938.983276367188 -487.242431640625 -1938.835083007812 -489.7059936523438 C -1937.626708984375 -509.8041381835938 -1930.6494140625 -529.226806640625 -1917.814697265625 -544.739990234375 C -1912.126953125 -551.6151733398438 -1908.092895507812 -560.0126342773438 -1906.4375 -569.4188232421875 C -1901.396362304688 -598.0635986328125 -1921.22509765625 -626.2422485351562 -1949.89111328125 -631.1588745117188 C -1953.826538085938 -631.8336791992188 -1957.734741210938 -632.0581665039062 -1961.562622070312 -631.8697509765625 C -1978.893798828125 -631.0166625976562 -1995.662475585938 -637.5670166015625 -2008.203857421875 -649.5587158203125 C -2017.74169921875 -658.67822265625 -2029.958251953125 -665.1964111328125 -2043.87744140625 -667.7376708984375 C -2071.0263671875 -672.6942749023438 -2104.4423828125 -659.2802734375 -2119.0283203125 -631.42431640625 C -2129.53515625 -611.358642578125 -2145.673828125 -594.7141723632812 -2165.943603515625 -584.6062622070312 C -2186.7998046875 -574.2063598632812 -2202.60595703125 -554.389404296875 -2206.9404296875 -529.710205078125 C -2213.96728515625 -489.7066345214844 -2186.612060546875 -449.7833557128906 -2146.75634765625 -441.9617004394531 C -2138.17919921875 -440.2781677246094 -2129.673828125 -440.1031494140625 -2121.506591796875 -441.2472534179688 C -2091.283447265625 -445.4805603027344 -2060.599853515625 -440.9496765136719 -2032.15771484375 -429.8864440917969 Z" fill="#20baf3" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(-0.965926, 0.258819, -0.258819, -0.965926, -2156.89, 251.26)" d="M -2032.15771484375 -429.8864440917969 C -2027.938720703125 -428.2454833984375 -2023.494384765625 -427.0004272460938 -2018.860961914062 -426.2040405273438 C -1982.006225585938 -419.8680114746094 -1945.944580078125 -445.404541015625 -1939.688232421875 -482.272705078125 C -1939.265747070312 -484.7618408203125 -1938.983276367188 -487.242431640625 -1938.835083007812 -489.7059936523438 C -1937.626708984375 -509.8041381835938 -1930.6494140625 -529.226806640625 -1917.814697265625 -544.739990234375 C -1912.126953125 -551.6151733398438 -1908.092895507812 -560.0126342773438 -1906.4375 -569.4188232421875 C -1901.396362304688 -598.0635986328125 -1921.22509765625 -626.2422485351562 -1949.89111328125 -631.1588745117188 C -1953.826538085938 -631.8336791992188 -1957.734741210938 -632.0581665039062 -1961.562622070312 -631.8697509765625 C -1978.893798828125 -631.0166625976562 -1995.662475585938 -637.5670166015625 -2008.203857421875 -649.5587158203125 C -2017.74169921875 -658.67822265625 -2029.958251953125 -665.1964111328125 -2043.87744140625 -667.7376708984375 C -2071.0263671875 -672.6942749023438 -2104.4423828125 -659.2802734375 -2119.0283203125 -631.42431640625 C -2129.53515625 -611.358642578125 -2145.673828125 -594.7141723632812 -2165.943603515625 -584.6062622070312 C -2186.7998046875 -574.2063598632812 -2202.60595703125 -554.389404296875 -2206.9404296875 -529.710205078125 C -2213.96728515625 -489.7066345214844 -2186.612060546875 -449.7833557128906 -2146.75634765625 -441.9617004394531 C -2138.17919921875 -440.2781677246094 -2129.673828125 -440.1031494140625 -2121.506591796875 -441.2472534179688 C -2091.283447265625 -445.4805603027344 -2060.599853515625 -440.9496765136719 -2032.15771484375 -429.8864440917969 Z" fill="#20baf3" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 47.0),
                  child: Container(
                      height: 150,
                      width: 150,
                      child: Image.asset('assets/images/user.png')),
                ),
              ),
              Center(
                  child: Container(
                child: const Text(
                  'Hello Jasmine!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Stack(children: [
                  lightblueWigetBuild(context, 350, 150),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: FontBuild(
                      text: 'Since last month',
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/medal.png'),
                          ValueListenableBuilder(
                              valueListenable: NumofMedal,
                              builder: (BuildContext context, int value,
                                  Widget? child) {
                                return SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Text(
                                    value.toString(),
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.blue[900]),
                                  ),
                                );
                              }),
                          Image.asset('assets/images/champion.png'),
                          ValueListenableBuilder(
                            builder: (BuildContext context, int value,
                                Widget? child) {
                              return SizedBox(
                                height: 50,
                                width: 50,
                                child: Text(
                                  value.toString(),
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.blue[900]),
                                ),
                              );
                            },
                            valueListenable: NumOfTrophies,
                          ),
                        ]),
                  )
                ]),
              ),
              Stack(children: [
                lightblueWigetBuild(context, 350, 400),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: FontBuild(
                          color: Colors.blue,
                          fontSize: 30,
                          text: 'Moderate\nEmotions within\nMinutes',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Stack(children: [
                          Container(
                              height: 50,
                              width: 50,
                              child: Image.asset('assets/images/circle.png')),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: 50,
                              child: const Text(
                                '20',
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 55.0),
                            child: Container(
                              margin: const EdgeInsets.only(left: 4),
                              child: const Text(
                                'mins',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0, top: 150),
                  child: Container(
                    child: const Text(
                      'Best for stressful times',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 170.0),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                        height: 125,
                        width: 150,
                        child: Image.asset('assets/images/computer.png')),
                    Container(
                      margin: EdgeInsets.only(right: 40),
                      height: 250,
                      width: 150,
                      child: Image.asset('assets/images/people.png'),
                    ),
                  ]),
                )
              ]),
              Container(
                child: TabBar(
                  labelColor: Colors.blue[800],
                  unselectedLabelColor: Colors.blue[70],
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  labelStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: 'Travel'),
                    Tab(
                      text: 'Animal',
                    ),
                    Tab(
                      text: 'Numbers',
                    )
                  ],
                ),
              ),
              Container(
                height: 200,
                width: 300,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      child: generateSmallContainer(context,
                          path1: 'assets/images/bus.png',
                          path2: 'assets/images/car.png'),
                    ),
                    Container(
                      child: generateSmallContainer(context,
                          path1: 'assets/images/monkey.png',
                          path2: 'assets/images/shiba.png'),
                    ),
                    Container(
                      child: generateSmallContainer(context,
                          path1: 'assets/images/calculator.png',
                          path2: 'assets/images/numbers.png'),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 40),
                child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 70,
                    width: 300,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.blue[900]),
                      child: const Text(
                        'Play now',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/mapping_shape');
                      },
                    )),
              )
            ],
          ),
        ),
      ]),
    ));
  }

  Widget generateSmallContainer(BuildContext context,
      {required String path1, required String path2}) {
    return Stack(children: [
      lightblueWigetBuild(context, 400, 200),
      Container(
        margin: const EdgeInsets.only(top: 30, left: 10),
        height: 40,
        width: 40,
        child: Image.asset('assets/images/circle.png'),
      ),
      Container(
          margin: const EdgeInsets.only(top: 30, left: 20),
          height: 40,
          width: 40,
          child: const Text(
            '5',
            style: TextStyle(fontSize: 30),
          )),
      Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: const EdgeInsets.only(right: 30),
                height: 100,
                width: 100,
                child: Image.asset(path1)),
            Container(
                margin: const EdgeInsets.only(right: 10),
                height: 100,
                width: 100,
                child: Image.asset(path2)),
          ],
        ),
      )
    ]);
  }
}
