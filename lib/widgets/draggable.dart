import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReorderableColumnDemo extends StatefulWidget {
  @override
  _ReorderableColumnDemoState createState() => _ReorderableColumnDemoState();
}

class _ReorderableColumnDemoState extends State<ReorderableColumnDemo> {
  List<SvgPicture> items = [
    SvgPicture.asset('Assets/Rectangle 39524.svg'),
    SvgPicture.asset('Assets/Rectangle 39521.svg'),
    SvgPicture.asset('Assets/Rectangle 39539.svg'),
    SvgPicture.asset('Assets/Rectangle 39539.svg'),
    SvgPicture.asset('Assets/Rectangle 39526.svg'),
  ];
  int? draggingIndex; // Переменная для отслеживания индекса перетаскиваемого элемента

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 2,
          height: 290, // Задаем высоту полосы
          color: Colors.white,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Выравнивание по левому краю
          children: List.generate(items.length, (index) {
            return DragTarget<int>(
              onAccept: (data) {
                setState(() {
                  int oldIndex = data;
                  int newIndex = index;
                  if (oldIndex < newIndex) {
                    newIndex -= 1; // Уменьшаем индекс, если перемещаем вниз
                  }
                  final item = items.removeAt(oldIndex);
                  items.insert(newIndex, item);
                  draggingIndex = null; // Сбрасываем переменную после завершения перетаскивания
                });
              },
              builder: (context, candidateData, rejectedData) {
                return LongPressDraggable<int>(
                  data: index,
                  child: DraggableItem(svgPicture: items[index]),
                  feedback: Material(
                    child: DraggableItem(svgPicture: items[index]),
                    elevation: 6.0,
                  ),
                  childWhenDragging: Container(),
                  onDragStarted: () {
                    setState(() {
                      draggingIndex = index; // Устанавливаем индекс при начале перетаскивания
                    });
                  },
                  onDragEnd: (details) {
                    setState(() {
                      draggingIndex = null; // Сбрасываем переменную после завершения перетаскивания
                    });
                  },
                );
              },
            );
          }),
        ),
      ],
    );
  }
}

class DraggableItem extends StatelessWidget {
  final SvgPicture svgPicture;

  DraggableItem({required this.svgPicture});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft, // Выравнивание по левому краю
      child: Container(
        key: ValueKey(svgPicture.toString()),
        margin: EdgeInsets.symmetric(vertical: 15.0),
        // padding: EdgeInsets.all(13.5),
        child: svgPicture,
      ),
    );
  }
}
