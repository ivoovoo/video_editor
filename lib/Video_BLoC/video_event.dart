abstract class VideoEvent {}

class TrimVideoEvent extends VideoEvent{
  final Duration start;
  final Duration end;

  TrimVideoEvent(this.start, this.end);
}

class RotateVideoEvent extends VideoEvent{
  final String videoPath;

  RotateVideoEvent(this.videoPath);
}

class AddTextOverlayEvent extends VideoEvent{
  final String text;
  final Duration start;
  final Duration end;

  AddTextOverlayEvent(this.text, this.start, this.end);
}

class AddMusicOverlayEvent extends VideoEvent{
  final String musicPath;
  final Duration start;
  final Duration end;

  AddMusicOverlayEvent(this.musicPath, this.start, this.end);
}

class AddVideoEffectEvent extends VideoEvent{
  final String effect; // Название эффекта
  final Duration start;
  final Duration end;

  AddVideoEffectEvent(this.effect, this.start, this.end);
}


// Другие события для наложения музыки и эффектов
