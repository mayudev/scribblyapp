bool chapterRead(int? progress, int chapterId) {
  return progress != null && progress >= chapterId;
}
