import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:practice01/src/ui/pages/example/bloc/expanded_bloc.dart';

class MyAppPage extends StatelessWidget {
  const MyAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmojiBloc(),
      child: const MyAppPageView(),
    );
  }
}

class MyAppPageView extends StatefulWidget {
  const MyAppPageView({super.key});

  @override
  State<MyAppPageView> createState() => _MyAppPageViewState();
}

class _MyAppPageViewState extends State<MyAppPageView> {
  late ScrollController scrollController = ScrollController();

  SlidingUpPanelController panelController = SlidingUpPanelController();

  double minBound = 0;

  double upperBound = 1.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: const Text(''),
            actions: const <Widget>[],
          ),
          body: Center(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                ),
                TextButton(
                  child: const Text('Show panel'),
                  onPressed: () {
                    panelController.expand();
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                ),
                TextButton(
                  child: const Text('Anchor panel'),
                  onPressed: () {
                    panelController.anchor();
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                ),
                TextButton(
                  child: const Text('Expand panel'),
                  onPressed: () {
                    panelController.expand();
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                ),
                TextButton(
                  child: const Text('Collapse panel'),
                  onPressed: () {
                    panelController.collapse();
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                ),
                TextButton(
                  child: const Text('Hide panel'),
                  onPressed: () {
                    panelController.hide();
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                ),
                TextButton(
                  child: const Text('minimumBound 0.3'),
                  onPressed: () {
                    setState(() {
                      minBound = 0.3;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                ),
                TextButton(
                  child: const Text('upperBound 0.7'),
                  onPressed: () {
                    setState(() {
                      upperBound = 0.7;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        SlidingUpPanelWidget(
          controlHeight: 50.0,
          anchor: 0.4,
          minimumBound: minBound,
          upperBound: upperBound,
          panelController: panelController,
          panelStatus: SlidingUpPanelStatus.hidden,
          onTap: () {
            ///Customize the processing logic
            if (SlidingUpPanelStatus.expanded == panelController.status) {
              panelController.collapse();
            } else {
              panelController.expand();
            }
          },
          enableOnTap: false,
          //Enable the onTap callback for control bar.
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: const ShapeDecoration(
              color: Colors.white,
              shadows: [
                BoxShadow(
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    color: Color(0x11000000))
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.menu,
                        size: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8.0,
                        ),
                      ),
                      Text(
                        'click or drag',
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                Flexible(
                  child: Container(
                    color: Colors.white,
                    child: ListView.separated(
                      controller: scrollController,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('list item $index'),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 0.5,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
