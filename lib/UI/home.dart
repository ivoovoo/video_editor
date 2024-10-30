import 'dart:io';

import 'package:capcut/Nav_BLoC/nav_event.dart';
import 'package:capcut/UI/edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../Nav_BLoC/nav_bloc.dart';
import '../Video_BLoC/video_bloc.dart';
import '../Video_BLoC/video_event.dart';
import '../widgets/lists.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final ImagePicker _picker = ImagePicker();

  void _pickVideo() async {

    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

    if (mounted && video != null) {
      context.read<NavigationBloc>().add(GoToScreenB());
      // MaterialPageRoute<void>(
      //   builder: (BuildContext context) => EditorWidget(videoPath: video.path),
      // );
    }
  }




  int _selectedIndex = 0; // Индекс выбранной кнопки

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index; // Обновляем индекс выбранной кнопки
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text('EIWQ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: _pickVideo,

              child: Container(
                width: 107,
                height: 100,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(31, 31, 31, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 13,
                    ),
                    SvgPicture.asset('Assets/Group 112901.svg'),
                    Text(
                      'Import',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInkWellButton(0, 'MY VIDEO'),
              _buildInkWellButton(1, 'MOOD'),
              _buildInkWellButton(2, 'R&B'),
              _buildInkWellButton(3, 'Pop'),
              _buildInkWellButton(4, 'Themes'),
            ],
          ),
          Expanded(
              flex: 1,
              child: PageView.builder(
                itemCount: listOfImages.length,
                itemBuilder: (context, index) {
                  return _buildPageItem(index);
                },
              )),
          Expanded(
            flex: 4,
            child: ListView.builder(
              itemCount: listOfImages.length,
              itemBuilder: (context, index) {
                return _buildListItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(listOfImages[index]),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listOfText[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    listOfAuthors[index],
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                listofTime[index],
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              ),
              SizedBox(width: 15),
              Icon(
                Icons.play_circle_fill_outlined,
                color: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      child: Container(
        width: 130,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              listOfImages[index],
              width: 100,
              height: 100,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  '01.04.2012',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
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

//-------------------//
//VIDEO EDITOR SCREEN//
//-------------------//
// class VideoEditor extends StatefulWidget {
//   const VideoEditor({super.key, required this.file});
//
//   final File file;
//
//   @override
//   State<VideoEditor> createState() => _VideoEditorState();
// }
//
// class _VideoEditorState extends State<VideoEditor> {
//   final _exportingProgress = ValueNotifier<double>(0.0);
//   final _isExporting = ValueNotifier<bool>(false);
//   final double height = 60;
//
//   late final VideoEditorController _controller = VideoEditorController.file(
//     widget.file,
//     minDuration: const Duration(seconds: 1),
//     maxDuration: const Duration(seconds: 10),
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     _controller
//         .initialize(aspectRatio: 9 / 16)
//         .then((_) => setState(() {}))
//         .catchError((error) {
//       // handle minumum duration bigger than video duration error
//       Navigator.pop(context);
//     }, test: (e) => e is VideoMinDurationError);
//   }
//
//   @override
//   void dispose() async {
//     _exportingProgress.dispose();
//     _isExporting.dispose();
//     _controller.dispose();
//     ExportService.dispose();
//     super.dispose();
//   }
//
//   void _showErrorSnackBar(String message) =>
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           duration: const Duration(seconds: 1),
//         ),
//       );
//
//   void _exportVideo() async {
//     _exportingProgress.value = 0;
//     _isExporting.value = true;
//
//     final config = VideoFFmpegVideoEditorConfig(
//       _controller,
//       // format: VideoExportFormat.gif,
//       // commandBuilder: (config, videoPath, outputPath) {
//       //   final List<String> filters = config.getExportFilters();
//       //   filters.add('hflip'); // add horizontal flip
//
//       //   return '-i $videoPath ${config.filtersCmd(filters)} -preset ultrafast $outputPath';
//       // },
//     );
//
//     await ExportService.runFFmpegCommand(
//       await config.getExecuteConfig(),
//       onProgress: (stats) {
//         _exportingProgress.value = config.getFFmpegProgress(stats.getTime());
//       },
//       onError: (e, s) => _showErrorSnackBar("Error on export video :("),
//       onCompleted: (file) {
//         _isExporting.value = false;
//         if (!mounted) return;
//
//         showDialog(
//           context: context,
//           builder: (_) => VideoResultPopup(video: file),
//         );
//       },
//     );
//   }
//
//   void _exportCover() async {
//     final config = CoverFFmpegVideoEditorConfig(_controller);
//     final execute = await config.getExecuteConfig();
//     if (execute == null) {
//       _showErrorSnackBar("Error on cover exportation initialization.");
//       return;
//     }
//
//     await ExportService.runFFmpegCommand(
//       execute,
//       onError: (e, s) => _showErrorSnackBar("Error on cover exportation :("),
//       onCompleted: (cover) {
//         if (!mounted) return;
//
//         showDialog(
//           context: context,
//           builder: (_) => CoverResultPopup(cover: cover),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: _controller.initialized
//             ? SafeArea(
//           child: Stack(
//             children: [
//               Column(
//                 children: [
//                   _topNavBar(),
//                   Expanded(
//                     child: DefaultTabController(
//                       length: 2,
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: TabBarView(
//                               physics:
//                               const NeverScrollableScrollPhysics(),
//                               children: [
//                                 Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     CropGridViewer.preview(
//                                         controller: _controller),
//                                     AnimatedBuilder(
//                                       animation: _controller.video,
//                                       builder: (_, __) => AnimatedOpacity(
//                                         opacity:
//                                         _controller.isPlaying ? 0 : 1,
//                                         duration: kThemeAnimationDuration,
//                                         child: GestureDetector(
//                                           onTap: _controller.video.play,
//                                           child: Container(
//                                             width: 40,
//                                             height: 40,
//                                             decoration:
//                                             const BoxDecoration(
//                                               color: Colors.white,
//                                               shape: BoxShape.circle,
//                                             ),
//                                             child: const Icon(
//                                               Icons.play_arrow,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 CoverViewer(controller: _controller)
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 200,
//                             margin: const EdgeInsets.only(top: 10),
//                             child: Column(
//                               children: [
//                                 TabBar(
//                                   tabs: [
//                                     Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.center,
//                                         children: const [
//                                           Padding(
//                                               padding: EdgeInsets.all(5),
//                                               child: Icon(
//                                                   Icons.content_cut)),
//                                           Text('Trim')
//                                         ]),
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.center,
//                                       children: const [
//                                         Padding(
//                                             padding: EdgeInsets.all(5),
//                                             child:
//                                             Icon(Icons.video_label)),
//                                         Text('Cover')
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Expanded(
//                                   child: TabBarView(
//                                     physics:
//                                     const NeverScrollableScrollPhysics(),
//                                     children: [
//                                       Column(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.center,
//                                         children: _trimSlider(),
//                                       ),
//                                       _coverSelection(),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           ValueListenableBuilder(
//                             valueListenable: _isExporting,
//                             builder: (_, bool export, Widget? child) =>
//                                 AnimatedSize(
//                                   duration: kThemeAnimationDuration,
//                                   child: export ? child : null,
//                                 ),
//                             child: AlertDialog(
//                               title: ValueListenableBuilder(
//                                 valueListenable: _exportingProgress,
//                                 builder: (_, double value, __) => Text(
//                                   "Exporting video ${(value * 100).ceil()}%",
//                                   style: const TextStyle(fontSize: 12),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         )
//             : const Center(child: CircularProgressIndicator()),
//       ),
//     );
//   }
//
//   Widget _topNavBar() {
//     return SafeArea(
//       child: SizedBox(
//         height: height,
//         child: Row(
//           children: [
//             Expanded(
//               child: IconButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 icon: const Icon(Icons.exit_to_app),
//                 tooltip: 'Leave editor',
//               ),
//             ),
//             const VerticalDivider(endIndent: 22, indent: 22),
//             Expanded(
//               child: IconButton(
//                 onPressed: () =>
//                     _controller.rotate90Degrees(RotateDirection.left),
//                 icon: const Icon(Icons.rotate_left),
//                 tooltip: 'Rotate unclockwise',
//               ),
//             ),
//             Expanded(
//               child: IconButton(
//                 onPressed: () =>
//                     _controller.rotate90Degrees(RotateDirection.right),
//                 icon: const Icon(Icons.rotate_right),
//                 tooltip: 'Rotate clockwise',
//               ),
//             ),
//             Expanded(
//               child: IconButton(
//                 onPressed: () => Navigator.push(
//                   context,
//                   MaterialPageRoute<void>(
//                     builder: (context) => CropPage(controller: _controller),
//                   ),
//                 ),
//                 icon: const Icon(Icons.crop),
//                 tooltip: 'Open crop screen',
//               ),
//             ),
//             const VerticalDivider(endIndent: 22, indent: 22),
//             Expanded(
//               child: PopupMenuButton(
//                 tooltip: 'Open export menu',
//                 icon: const Icon(Icons.save),
//                 itemBuilder: (context) => [
//                   PopupMenuItem(
//                     onTap: _exportCover,
//                     child: const Text('Export cover'),
//                   ),
//                   PopupMenuItem(
//                     onTap: _exportVideo,
//                     child: const Text('Export video'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String formatter(Duration duration) => [
//     duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
//     duration.inSeconds.remainder(60).toString().padLeft(2, '0')
//   ].join(":");
//
//   List<Widget> _trimSlider() {
//     return [
//       AnimatedBuilder(
//         animation: Listenable.merge([
//           _controller,
//           _controller.video,
//         ]),
//         builder: (_, __) {
//           final int duration = _controller.videoDuration.inSeconds;
//           final double pos = _controller.trimPosition * duration;
//
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: height / 4),
//             child: Row(children: [
//               Text(formatter(Duration(seconds: pos.toInt()))),
//               const Expanded(child: SizedBox()),
//               AnimatedOpacity(
//                 opacity: _controller.isTrimming ? 1 : 0,
//                 duration: kThemeAnimationDuration,
//                 child: Row(mainAxisSize: MainAxisSize.min, children: [
//                   Text(formatter(_controller.startTrim)),
//                   const SizedBox(width: 10),
//                   Text(formatter(_controller.endTrim)),
//                 ]),
//               ),
//             ]),
//           );
//         },
//       ),
//       Container(
//         width: MediaQuery.of(context).size.width,
//         margin: EdgeInsets.symmetric(vertical: height / 4),
//         child: TrimSlider(
//           controller: _controller,
//           height: height,
//           horizontalMargin: height / 4,
//           child: TrimTimeline(
//             controller: _controller,
//             padding: const EdgeInsets.only(top: 10),
//           ),
//         ),
//       )
//     ];
//   }
//
//   Widget _coverSelection() {
//     return SingleChildScrollView(
//       child: Center(
//         child: Container(
//           margin: const EdgeInsets.all(15),
//           child: CoverSelection(
//             controller: _controller,
//             size: height + 10,
//             quantity: 8,
//             selectedCoverBuilder: (cover, size) {
//               return Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   cover,
//                   Icon(
//                     Icons.check_circle,
//                     color: const CoverSelectionStyle().selectedBorderColor,
//                   )
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
