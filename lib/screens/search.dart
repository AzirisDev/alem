import 'package:alem/bloc/search_bloc.dart';
import 'package:alem/bloc/search_event.dart';
import 'package:alem/bloc/search_state.dart';
import 'package:alem/repo/search_repo.dart';
import 'package:alem/screens/widgets/planet_flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var cityController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (context) => SearchBloc(SearchRepository()),
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  PlanetFlare(),
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is IsNotSearched) {
                        return Container(
                          padding: const EdgeInsets.only(
                            left: 32,
                            right: 32,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              const Text(
                                "Search",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              const Text(
                                "Instantly",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                controller: cityController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.white70,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.white70,
                                          style: BorderStyle.solid)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.blue,
                                          style: BorderStyle.solid)),
                                  hintText: "City Name",
                                  hintStyle: TextStyle(color: Colors.white70),
                                ),
                                style: const TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Container(
                                width: double.infinity,
                                height: 50,
                                child: TextButton(
                                  onPressed: () {
                                    context.read<SearchBloc>().add(
                                          FetchInfo(cityController.text),
                                        );
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.lightBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  child: const Text(
                                    'Search',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                            ],
                          ),
                        );
                      } else if (state is IsLoading) {
                        return CircularProgressIndicator();
                      } else if (state is IsLoaded) {
                        return Container(
                          padding: const EdgeInsets.only(
                            left: 32,
                            right: 32,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                cityController.text[0].toUpperCase() +
                                    cityController.text.substring(1),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.getInfo.time,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(
                                    state.getInfo.isDayTime
                                        ? Icons.wb_sunny
                                        : Icons.nightlight_round,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: ListTile(
                                  tileColor: Colors.white,
                                  leading: FaIcon(
                                    FontAwesomeIcons.thermometerHalf,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    'Temperature',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  trailing: Text(
                                    state.getInfo.temp
                                            .toString()
                                            .substring(0, 4) +
                                        ' C\u00B0',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: ListTile(
                                  tileColor: Colors.white,
                                  leading: FaIcon(
                                    FontAwesomeIcons.compress,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    'Pressure',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  trailing: Text(
                                    '${state.getInfo.pressure} mb',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: ListTile(
                                  tileColor: Colors.white,
                                  leading: FaIcon(
                                    FontAwesomeIcons.sun,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    'Humidity',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  trailing: Text(
                                    '${state.getInfo.humidity} %',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: double.infinity,
                                height: 50,
                                child: TextButton(
                                  onPressed: () {
                                    context.read<SearchBloc>().add(ResetInfo());
                                    setState(() {
                                      cityController.text = '';
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.lightBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  child: const Text(
                                    'Back',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        );
                      }
                      return Container(
                        padding: const EdgeInsets.only(
                          left: 32,
                          right: 32,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250,
                            ),
                            Text(
                              'Error',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  context.read<SearchBloc>().add(ResetInfo());
                                  setState(() {
                                    cityController.text = '';
                                  });
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.lightBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                child: const Text(
                                  'Try again',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
