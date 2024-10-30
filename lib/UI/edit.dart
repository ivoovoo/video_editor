import 'dart:io';

import 'package:capcut/widgets/lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

import '../Video_BLoC/video_bloc.dart';
import '../Video_BLoC/video_state.dart';
import '../widgets/draggable.dart';

class VideoEditorScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VideoBloc, VideoState>(
        builder: (context, state) {
          if (state is VideoInitialState) {
            return const Center(child: Text('Загрузите видео'));
          } else if (state is VideoLoadedState) {
            return EditorWidget(videoPath: state.videoPath);
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}



class EditorWidget extends StatefulWidget {
  final String videoPath;

  const EditorWidget({super.key, required this.videoPath});

  @override
  State<EditorWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {
  int _selectIndex = 0;

  void _onPressed(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      // Stack(
      //   children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: Colors.black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                _controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                    : Container(),
                _buildTextOverlayControls(),
                _buildMusicOverlayControls(),
                _buildTrimControls(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.play_circle_fill_rounded,
                        color: Colors.white,
                      ),
                      Row(
                        children: [
                          InkWell(
                            child: SvgPicture.asset('Assets/Repeate 4.svg'),
                            onTap: () {},
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            '00:06/00:12',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            child: SvgPicture.asset('Assets/Repeate 3.svg'),
                            onTap: () {},
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.check_box_outline_blank_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 195,
                    ),
                    ReorderableColumnDemo(),
                  ],
                ),
                const SizedBox(
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
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          // Image.asset('Assets/Rectangle 39530.png'),
          // Positioned(
          //   top: 50,
          //   child: Padding(
          //     padding: const EdgeInsets.all(15.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         SvgPicture.asset('Assets/Group 10975.svg'),
          //         SvgPicture.asset('Assets/download.svg'),
          //       ],
          //     ),
          //   ),
          // ),
        // ],
      // ),
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
            style: const TextStyle(
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
      decoration: const BoxDecoration(
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
              _buildShowButton(0, 'None'),
              _buildShowButton(1, 'TRENDS'),
              _buildShowButton(2, 'CHILL'),
              _buildShowButton(3, 'POPULAR'),
              _buildShowButton(4, 'SOUNDS'),
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
      decoration: const BoxDecoration(
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
              _buildShowButton(0, 'None'),
              _buildShowButton(1, 'TRENDS'),
              _buildShowButton(2, 'CHILL'),
              _buildShowButton(3, 'POPULAR'),
              _buildShowButton(4, 'SOUNDS'),
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
      decoration: const BoxDecoration(
        color: Colors.black, // Черный цвет фона контейнера
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), // Закругление верхнего левого угла
          topRight: Radius.circular(20), // Закругление верхнего правого угла
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Настройка текста',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          // Здесь можно добавить элементы для настройки текста
          const Text('Здесь вы можете настроить текст.'),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Закрываем диалог
            },
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSelection() {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: const BoxDecoration(
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
              _buildShowButton(0, 'None'),
              _buildShowButton(1, 'Vibrant'),
              _buildShowButton(2, 'Intense'),
              _buildShowButton(3, 'Classy'),
              _buildShowButton(4, 'B&W'),
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
      decoration: const BoxDecoration(
        color: Colors.black, // Черный цвет фона контейнера
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), // Закругление верхнего левого угла
          topRight: Radius.circular(20), // Закругление верхнего правого угла
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('По умолчанию',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('Это содержимое по умолчанию.'),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Закрываем диалог
            },
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  Widget _buildShowButton(int index, String label) {
    return InkWell(
      onTap: () => _onPressed(index),
      highlightColor: Colors.transparent, // Remove highlight color
      splashColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: _selectIndex == index
            ? ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 185, 81, 1),
                      Color.fromRGBO(206, 80, 224, 1)
                    ],
                  ).createShader(bounds);
                },
                child: Text(
                  label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      // Цвет текста по умолчанию
                      color: Colors.white),
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
      ),
    );
  }

  Widget _buildTextOverlayControls() {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Введите текст'),
          onSubmitted: (text) {
            // Логика для добавления текста на видео
          },
        ),
        // Элементы управления для регулировки времени отображения текста
      ],
    );
  }

  Widget _buildMusicOverlayControls() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Логика для выбора музыки
          },
          child: const Text('Добавить музыку'),
        ),
        // Элементы управления для регулировки времени музыки
      ],
    );
  }

  Widget _buildTrimControls() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Логика для обрезки видео
          },
          child: const Text('Обрезать видео'),
        ),
      ],
    );
  }
}

