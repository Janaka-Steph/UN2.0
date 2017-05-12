contract ChapterGlobal is Chapter {
}

contract ChapterNational is Chapter {
  bytes3 nationalChapterId;
}

contract ChapterLocal is Chapter {
  bytes5 localChapterId;
}

contract SubChapter is Chapter {
  bytes2 subChapterId;
}
