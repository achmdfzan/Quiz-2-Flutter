import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  String valuePertama = "Active Turn Over";
  String valueKedua = "1D";

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> itemsPertama = [
      const DropdownMenuItem<String>(
        value: "Active Turn Over",
        child: Text("Active Turn Over"),
      ),
      const DropdownMenuItem<String>(
        value: "Active Volume",
        child: Text("Active Volume"),
      ),
    ];

    List<DropdownMenuItem<String>> itemsKedua = [
      const DropdownMenuItem<String>(
        value: "1D",
        child: Text("1D"),
      ),
      const DropdownMenuItem<String>(
        value: "1W",
        child: Text("1W"),
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello App',
      home: Scaffold(
        appBar: AppBar(
            leading: const FlutterLogo(),
            backgroundColor: Colors.blueGrey,
            title: const Text('Quiz Flutter'),
            actions: const <Widget>[ButtonNamaKelompok(), ButtonPerjanjian()]),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton(
                    isExpanded: true,
                    value: valuePertama,
                    items: itemsPertama,
                    onChanged: (String? newValue) {
                      setState(() {
                        if (newValue != null) {
                          valuePertama = newValue;
                        }
                      });
                    },
                  ),
                ),
                DropdownButton(
                  value: valueKedua,
                  items: itemsKedua,
                  onChanged: (String? newValue) {
                    setState(() {
                      if (newValue != null) {
                        valueKedua = newValue;
                      }
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: (valueKedua == "1D" ? const Data1D() : const Data1W()),
            ),
          ],
        ),
      ),
    );
  }
}

class Data1D extends StatefulWidget {
  const Data1D({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return Data1DState();
  }
}

class Data1DState extends State<Data1D> {
  List<Data> listData = [];

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 20; i++) {
      listData.add(Data(
        kode: "KODE$i",
        nama: "Nama Perusahaan $i",
        vol: "${i * 5}M",
        turnOver: "${i * 32.75}B",
        harga: "${i * 100}",
        naikTurun: "${i % 2 == 0 ? '-' : '+'}$i",
        pctNaikTurun: "${i % 2 == 0 ? '-' : '+'}$i%",
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(border: Border.all()),
          padding: const EdgeInsets.all(14),
          child: listData[index],
        );
      },
    );
  }
}

class Data1W extends StatefulWidget {
  const Data1W({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return Data1WState();
  }
}

class Data1WState extends State<Data1W> {
  List<Data> listData = [];

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 20; i++) {
      listData.add(Data(
        kode: "KODE$i",
        nama: "Nama Perusahaan $i",
        vol: "${i * 5}M",
        turnOver: "${i * 32.75}B",
        harga: "${i * 100}",
        naikTurun: "${i % 3 == 0 ? '-' : '+'}${i * 7}",
        pctNaikTurun: "${i % 3 == 0 ? '-' : '+'}${i * 7}%",
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(border: Border.all()),
          padding: const EdgeInsets.all(14),
          child: listData[index],
        );
      },
    );
  }
}

class Data extends StatelessWidget {
  final String kode;
  final String nama;
  final String vol;
  final String turnOver;
  final String harga;
  final String naikTurun;
  final String pctNaikTurun;

  const Data({
    Key? key,
    required this.kode,
    required this.nama,
    required this.vol,
    required this.turnOver,
    required this.harga,
    required this.naikTurun,
    required this.pctNaikTurun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isGreen = naikTurun[0] == '+' ? true : false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              kode,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const Text("Volume"),
            const Text("Turn Over"),
          ],
        ),
        Column(
          children: [
            Text(nama, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(vol),
            Text(turnOver)
          ],
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
          child: Text(
            harga,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isGreen ? Colors.green : Colors.red,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          width: 75,
          height: 75,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(),
            color: isGreen ? Colors.green : Colors.red,
          ),
          child: Column(
            children: [
              Text(
                naikTurun,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                pctNaikTurun,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ButtonNamaKelompok extends StatelessWidget {
  const ButtonNamaKelompok({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.account_circle_rounded),
      onPressed: () {
        // icon account di tap
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Kelompok 6 C1'),
            content: const Text(
                'Achmad Fauzan\n(achmdfzan@upi.edu)\n\nAnandita Kusumah Mulyadi\n(ananditakusumahm@upi.edu)'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ButtonPerjanjian extends StatelessWidget {
  const ButtonPerjanjian({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.access_alarm_rounded),
      onPressed: () {
        // icon setting ditap
        const snackBar = SnackBar(
          duration: Duration(seconds: 20),
          content: Text(
              'Kami berjanji tidak akan berbuat curang dan atau membantu kelompok lain berbuat curang'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}
