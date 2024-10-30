class VideoState {}

class VideoInitialState extends VideoState {}

class VideoLoadedState extends VideoState {
  final String videoPath;

  VideoLoadedState(this.videoPath);
}

class VideoTrimmingState extends VideoState {
  final String videoPath;
  final Duration start;
  final Duration end;

  VideoTrimmingState(this.videoPath, this.start, this.end);
}

class VideoRotatedState extends VideoState {
  final String rotatedVideoPath;

  VideoRotatedState(this.rotatedVideoPath);
}

class VideoTextOverlayState extends VideoState {
  final String videoPath;
  final String text;
  final Duration start;
  final Duration end;

  VideoTextOverlayState(this.videoPath, this.text, this.start, this.end);
}

class VideoErrorState extends VideoState {
  final String message;

  VideoErrorState(this.message);
}

class VideoMusicOverlayState extends VideoState {
  final String musicPath;
  final Duration start;
  final Duration end;

  VideoMusicOverlayState(this.musicPath, this.start, this.end);
}

class VideoEffectState extends VideoState {
  final String effect;
  final Duration start;
  final Duration end;

  VideoEffectState(this.effect, this.start, this.end);
}

// Определение состояния для поворота видео


