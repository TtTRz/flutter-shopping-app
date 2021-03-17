import "package:flutter/material.dart";
import 'package:flutter_2d_amap/flutter_2d_amap.dart';

class FeaturePage extends StatefulWidget {
  @override
  _FeaturePage createState() => _FeaturePage();
}

class _FeaturePage extends State<FeaturePage> {
  @override
  Widget build(BuildContext context) {
    List<PoiSearch> _list = [];
    int _index = 0;
    AMap2DController _aMap2DController;
    final ScrollController _controller = ScrollController();
    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    @override
    void initState() {
      super.initState();

      /// iOS配置key
      Flutter2dAMap.setApiKey("072437aacb5008912cc5bb89cbc39a55");
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: SearchBar(
      //   hintText: '搜索地址',
      //   onPressed: (text) {
      //     _controller.animateTo(0.0,
      //         duration: const Duration(milliseconds: 10), curve: Curves.ease);
      //     _index = 0;
      //     if (_aMap2DController != null) {
      //       _aMap2DController.search(text);
      //     }
      //   },
      // ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: AMap2DView(
                webKey: '4e479545913a3a180b3cffc267dad646',
                onPoiSearched: (result) {
                  _controller.animateTo(0.0,
                      duration: const Duration(milliseconds: 10),
                      curve: Curves.ease);
                  _index = 0;
                  _list = result;
                  setState(() {});
                },
                onAMap2DViewCreated: (controller) {
                  _aMap2DController = controller;
                },
              ),
            ),
            Expanded(
              flex: 11,
              child: _list.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      controller: _controller,
                      itemCount: _list.length,
                      separatorBuilder: (_, index) => const Divider(),
                      itemBuilder: (_, index) {
                        return _AddressItem(
                          isSelected: _index == index,
                          date: _list[index],
                          onTap: () {
                            _index = index;
                            if (_aMap2DController != null) {
                              _aMap2DController.move(_list[index].latitude,
                                  _list[index].longitude);
                            }
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressItem extends StatelessWidget {
  const _AddressItem({
    Key key,
    @required this.date,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  final PoiSearch date;
  final bool isSelected;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 50.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                date.provinceName +
                    ' ' +
                    date.cityName +
                    ' ' +
                    date.adName +
                    ' ' +
                    date.title,
              ),
            ),
            Visibility(
              visible: isSelected,
              child: const Icon(Icons.done, color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}
