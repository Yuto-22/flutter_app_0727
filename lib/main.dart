import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SlidePage(),
      ),
    );
  }
}



class SlidePage extends StatefulWidget {
  @override
  _SlideshowState createState() => _SlideshowState();
}


class _SlideshowState extends State<SlidePage> {

  // ページコントローラ
  final PageController controller = PageController(viewportFraction: 0.8);

  // ページインデックス
  int currentPage = 0;

  // データ
  final List<String> _imageList = [
    "assets/アイコン.png",
    "assets/image_27.png",
    "assets/image_01.png",
  ];


  @override
  void initState() {

    super.initState();

    // ページコントローラのページ遷移を監視しページ数を丸める
    controller.addListener(() {
      int next = controller.page!.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }


  /*
   * アニメーションカード生成
   */
  AnimatedContainer _createCardAnimate(String imagePath, bool active) {

    // アクティブと非アクティブのアニメーション設定値
    final double top = active ? 100 : 200;
    final double side = active ? 0 : 40;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50.0, right: side, left: side),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: Image.asset(imagePath).image,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return PageView.builder(
      controller: controller,
      itemCount: _imageList.length,
      itemBuilder: (context, int currentIndex) {

        // アクティブ値
        bool active = currentIndex == currentPage;

        // カードの生成して返す
        return _createCardAnimate(
          _imageList[currentIndex],
          active,
        );
      },
    );
  }
}