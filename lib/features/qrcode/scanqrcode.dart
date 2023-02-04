import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/appbar.dart';

import '../blocs.dart';
import '../repositories.dart';

class ScanQR extends StatefulWidget {
  static const String routeName = '/scanqr';

  const ScanQR({super.key});

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return const ScanQR();
        });
  }

  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String? image;
  String _scanBarcode = '-';
  String message = 'Member already exist in your list';
  bool exist = false;
  bool show = false;

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> barcodeScan() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> addPeople(
      {required String username, required String persona}) async {
    await PeopleRepository().savePeople(
        email: _scanBarcode,
        username: username,
        persona: persona,
        hot: false,
        blocked: false,
        reported: false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Scan QRCode',
      ),
      body: BlocProvider(
        create: (context) => PeopleBloc(
          peopleRepository: PeopleRepository(),
          authBloc: AuthBloc(authRepository: AuthRepository()),
        ),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            if (profileState is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (profileState is ProfileLoaded) {
              return BlocBuilder<PeopleBloc, PeopleState>(
                builder: (context, peopleState) {
                  if (peopleState is PeopleLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (peopleState is PeopleLoaded) {
                    return Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/scafold_bkg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flex(
                                        direction: Axis.vertical,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              height: 65,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                                  onPressed: () async {
                                                    barcodeScan();
                                                  },
                                                  child: Text(
                                                    'Tap to Scan',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 28,
                                                        color: Theme.of(context)
                                                            .secondaryHeaderColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )))
                                        ]),
                                    const SizedBox(height: 20),
                                    Text('Scan result : $_scanBarcode\n',
                                        style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(height: 10),
                                    Visibility(
                                      visible:
                                          _scanBarcode == '-' ? false : true,
                                      child: SizedBox(
                                        height: 45,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .backgroundColor),
                                          onPressed: () async {
                                            PeopleRepository()
                                                .searchPeople(
                                                    email: _scanBarcode)
                                                .then((value) {
                                              if (value.email == null) {
                                                PeopleRepository()
                                                    .getPeople(
                                                        email: _scanBarcode)
                                                    .then((value) {
                                                  if (value.email != '') {
                                                    addPeople(
                                                      username: value.name!,
                                                      persona: value.gender!,
                                                    );
                                                  }
                                                });
                                                setState(() {
                                                  exist = true;
                                                });
                                              } else {
                                                print(message);
                                                setState(() {
                                                  show = true;
                                                });
                                              }
                                            });
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(FontAwesomeIcons.plus),
                                              const SizedBox(width: 10),
                                              Text(
                                                'Add to People List',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Visibility(
                                      visible: exist,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.userCheck,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(width: 15),
                                          Text(
                                            'Member added successfully',
                                            style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: show,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.usersRectangle,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(width: 15),
                                          Text(
                                            message,
                                            style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const Text('Something went wrong...');
                },
              );
            }
            return const Text('Something went wrong...');
          },
        ),
      ),
    );
  }
}
