import 'package:capcut/widgets/lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

import '../widgets/draggable.dart';

class EditorWidget extends StatefulWidget {
  const EditorWidget({super.key});

  @override
  State<EditorWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {
  int _selectedIndex = 0; // Индекс выбранной кнопки

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index; // Обновляем индекс выбранной кнопки
    });
  }

  // late VideoPlayerController _controller;
  // double _sliderValue = 0.0;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.asset('assets/video.mp4')
  //     ..initialize().then((_) {
  //       setState(() {});
  //       _controller.play();
  //       _controller.addListener(() {
  //         setState(() {
  //           _sliderValue = _controller.value.position.inSeconds.toDouble();
  //         });
  //       });
  //     });
  // }
  //
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.play_circle_fill_rounded,
                        color: Colors.white,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('Assets/Repeate 4.svg'),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            '00:06/00:12',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          SvgPicture.asset('Assets/Repeate 3.svg'),
                        ],
                      ),
                      Icon(
                        Icons.check_box_outline_blank_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 195,
                    ),
                    ReorderableColumnDemo(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: SvgPicture.asset('Assets/Group 10991.svg'),
                      onTap: () {},
                    ),
                    _buildSelectionButton(0),
                    _buildSelectionButton(1),
                    _buildSelectionButton(2),
                    _buildSelectionButton(3),
                    _buildSelectionButton(4),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Image.asset('Assets/Rectangle 39530.png'),
          Positioned(
            top: 50,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('Assets/Group 10975.svg'),
                  SvgPicture.asset('Assets/download.svg'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionButton(int index) {
    return InkWell(
      onTap: () {
        _showCustomDialog(context, index);
      },
      highlightColor: Colors.transparent, // Remove highlight color
      splashColor: Colors.transparent,
      child: Column(
        children: [
          SvgPicture.asset(listOfSvg[index]),
          Text(
            listOfTitle[index],
            style: TextStyle(
                color: Colors.grey, fontSize: 8, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  void _showCustomDialog(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildBottomSheetContent(context, index);
      },
    );
  }

  Widget _buildBottomSheetContent(BuildContext context, int index) {
    switch (index) {
      case 0:
        return _buildMusicSelection();
      case 1:
        return _buildEffectsSelection();
      case 2:
        return _buildTextSettings();
      case 3:
        return _buildFiltersSelection();
      default:
        return _buildDefaultContent();
    }
  }

  Widget _buildMusicSelection() {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
      color: Colors.black, // Черный цвет фона контейнера
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20), // Закругление верхнего левого угла
        topRight: Radius.circular(20), // Закругление верхнего правого угла
      ),
    ),
    child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInkWellButton(0, 'None'),
              _buildInkWellButton(1, 'TRENDS'),
              _buildInkWellButton(2, 'CHILL'),
              _buildInkWellButton(3, 'POPULAR'),
              _buildInkWellButton(4, 'SOUNDS'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEffectsSelection() {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
        color: Colors.black, // Черный цвет фона контейнера
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), // Закругление верхнего левого угла
          topRight: Radius.circular(20), // Закругление верхнего правого угла
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInkWellButton(0, 'None'),
              _buildInkWellButton(1, 'TRENDS'),
              _buildInkWellButton(2, 'CHILL'),
              _buildInkWellButton(3, 'POPULAR'),
              _buildInkWellButton(4, 'SOUNDS'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextSettings() {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
        color: Colors.black, // Черный цвет фона контейнера
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), // Закругление верхнего левого угла
          topRight: Radius.circular(20), // Закругление верхнего правого угла
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Настройка текста',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          // Здесь можно добавить элементы для настройки текста
          Text('Здесь вы можете настроить текст.'),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Закрываем диалог
            },
            child: Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSelection() {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
        color: Colors.black, // Черный цвет фона контейнера
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), // Закругление верхнего левого угла
          topRight: Radius.circular(20), // Закругление верхнего правого угла
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInkWellButton(0, 'None'),
              _buildInkWellButton(1, 'Vibrant'),
              _buildInkWellButton(2, 'Intense'),
              _buildInkWellButton(3, 'Classy'),
              _buildInkWellButton(4, 'B&W'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultContent() {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
        color: Colors.black, // Черный цвет фона контейнера
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), // Закругление верхнего левого угла
          topRight: Radius.circular(20), // Закругление верхнего правого угла
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('По умолчанию',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('Это содержимое по умолчанию.'),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Закрываем диалог
            },
            child: Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  Widget _buildInkWellButton(int index, String label) {
    return InkWell(
      onTap: () => _onButtonPressed(index),
      highlightColor: Colors.transparent, // Remove highlight color
      splashColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: _selectedIndex == index
            ? ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [
                Color.fromRGBO(255, 185, 81, 1),
                Color.fromRGBO(206, 80, 224, 1)
              ],
            ).createShader(bounds);
          },
          child: Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                // Цвет текста по умолчанию
                color: Colors.white),
          ),
        )
            : Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
    );
  }
}


}
