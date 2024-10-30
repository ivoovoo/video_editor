import 'package:capcut/Video_BLoC/video_event.dart';
import 'package:capcut/Video_BLoC/video_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitialState()) {
    on<TrimVideoEvent>(_onTrimVideo);
    on<RotateVideoEvent>(_onRotateVideo);
    on<AddTextOverlayEvent>(_onAddTextOverlay);
    on<AddMusicOverlayEvent>(_onAddMusicOverlay);
    on<AddVideoEffectEvent>(_onAddVideoEffect);

  }

  Future<void> _onTrimVideo(TrimVideoEvent event,
      Emitter<VideoState> emit) async {
    if (state is VideoLoadedState) {
      final currentState = state as VideoLoadedState;
      emit(VideoTrimmingState(currentState.videoPath, event.start, event.end));

      final FlutterFFmpeg _ffmpeg = FlutterFFmpeg();
      final outputPath = '${currentState.videoPath.replaceAll(
          ".mov", "_trimmed.mov")}';

      // Команда для обрезки видео
      String command = '-i ${currentState.videoPath} -ss ${event.start
          .inSeconds} -to ${event.end.inSeconds} -c copy $outputPath';

      // Выполните команду
      int rc = await _ffmpeg.execute(command);

      if (rc == 0) {
        emit(VideoTextOverlayState(
            outputPath, '', event.start, event.end)); // Успешно обрезано
      } else {
        emit(VideoErrorState('Ошибка при обрезке видео'));
      }
    }
  }

  Future<void> _onRotateVideo(RotateVideoEvent event,
      Emitter<VideoState> emit) async {
    if (state is VideoLoadedState) {
      final FlutterFFmpeg _ffmpeg = FlutterFFmpeg();
      final outputPath = '${event.videoPath.replaceAll(
          ".mov", "_rotated.mov")}';

      // Команда для поворота видео на 90 градусов
      String command = '-i ${event.videoPath} -vf "transpose=1" $outputPath';

      // Выполните команду
      int rc = await _ffmpeg.execute(command);

      if (rc == 0) {
        emit(VideoRotatedState(outputPath)); // Успешно повернуто
      } else {
        emit(VideoErrorState('Ошибка при повороте видео'));
      }
    }
  }

  Future<void> _onAddTextOverlay(AddTextOverlayEvent event,
      Emitter<VideoState> emit) async {
    if (state is VideoLoadedState) {
      final currentState = state as VideoLoadedState;
      emit(VideoTextOverlayState(
          currentState.videoPath, event.text, event.start, event.end));

      final FlutterFFmpeg _ffmpeg = FlutterFFmpeg();
      final outputPath = '${currentState.videoPath.replaceAll(
          ".mov", "_text_overlay.mov")}';

      // Команда для добавления текста на видео
      String command = '-i ${currentState
          .videoPath} -vf "drawtext=text=\'${event
          .text}\':x=10:y=10:enable=\'between(t,${event.start.inSeconds},${event
          .end.inSeconds})\'" $outputPath';

      // Выполните команду
      int rc = await _ffmpeg.execute(command);

      if (rc == 0) {
        emit(VideoTextOverlayState(outputPath, event.text, event.start,
            event.end)); // Успешно добавлено наложение текста
      } else {
        emit(VideoErrorState('Ошибка при добавлении текстового наложения'));
      }
    }
  }
  Future<void> _onAddMusicOverlay(AddMusicOverlayEvent event, Emitter<VideoState> emit) async {
    // if (state is VideoLoadedState) {
    //   final currentState = state as VideoLoadedState;
    //   emit(VideoMusicOverlayState(event.musicPath, event.start, event.end));
    //
    //   final FlutterFFmpeg _ffmpeg = FlutterFFmpeg();
    //   final outputPath = '${currentState.videoPath.replaceAll(".mov", "_music_overlay.mov")}';
    //
    //   // Команда для наложения музыки на видео
    //   String command = '-i ${currentState.videoPath} -i ${event.musicPath} -filter_complex "[0:a][1:a]amix=inputs=2:duration=first:dropout_transition=3" -c:v copy -c:a aac -strict experimental $outputPath';
    //
    //   // Выполните команду
    //   int rc = await _ffmpeg.execute(command);
    //
    //   if (rc == 0) {
    //     emit(VideoMusicOverlayState(outputPath, event.start, event.end)); // Успешно добавлено наложение музыки
    //   } else {
    //     emit(VideoErrorState('Ошибка при добавлении музыки на видео'));
    //   }
    // }
  }

  Future<void> _onAddVideoEffect(AddVideoEffectEvent event, Emitter<VideoState> emit) async {
    // if (state is VideoLoadedState) {
    //   final currentState = state as VideoLoadedState;
    //   emit(VideoEffectState(event.effect, event.start, event.end));
    //
    //   final FlutterFFmpeg _ffmpeg = FlutterFFmpeg();
    //   final outputPath = '${currentState.videoPath.replaceAll(".mov", "_effect_${event.effect}.mov")}';
    //
    //   // Команда для добавления эффекта на видео
    //   String command = '-i ${currentState.videoPath} -vf "${event.effect}=enable=\'between(t,${event.start.inSeconds},${event.end.inSeconds})\'" $outputPath';
    //
    //   // Выполните команду
    //   int rc = await _ffmpeg.execute(command);
    //
    //   if (rc == 0) {
    //     emit(VideoEffectState(event.effect, event.start, event.end)); // Успешно добавлен эффект
    //   } else {
    //     emit(VideoErrorState('Ошибка при добавлении эффекта на видео'));
    //   }
    // }
  }
}