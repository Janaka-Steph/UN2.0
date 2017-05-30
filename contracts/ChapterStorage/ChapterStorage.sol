pragma solidity ^0.4.11;

import './ChapterGlobalStorage.sol';
import './ChapterNationalStorage.sol';
import './ChapterLocalStorage.sol';

/// @title Chapter Storage
/// @author 97Network
contract ChapterStorage {

  // chapterId: National chapter [000], Local chapter [00000], Sub-chapter [00]

  // Number of local chapters
  uint24 chaptersLocalIndex;
  // Number of national chapters
  uint24 chaptersNationalIndex;

  struct Forum {
    address[] members;
  }

  struct Secretariat {
       address secretary;
       address[] members;
   }

  struct ChapterGlobal {
    mapping(uint24 => ChapterNational) chaptersNational;
    Forum forum;
    mapping(uint24 => SubChapter) globalSubChapters;
    mapping(bytes32 => address) moderators;
    address president;
    Secretariat secretariat;
  }

  struct ChapterNational {
    mapping(uint24 => ChapterLocal) chaptersLocal;
    Forum forum;
    mapping(bytes32 => address) moderators;
    uint24 chapterNationalId;
    mapping(uint24 => SubChapter) nationalSubChapters;
    address president;
    Secretariat secretariat;
  }

  struct ChapterLocal {
    uint24 chapterLocalId;
    mapping(uint24 => SubChapter) localSubChapters;
    Forum forum;
    mapping(bytes32 => address) moderators;
    address president;
    Secretariat secretariat;
  }

  struct SubChapter {
    uint24 subChapterId;
    bytes32 description;
    address moderator;
  }

  // There is one global chapter
  ChapterGlobal chapterGlobal;

  event LogChapterBodies (
    address indexed chapterId,
    uint index,
    address forum,
    address executiveCommittee,
    address boardOfDirectors,
    address secretariat,
    address chapterPresident,
    address chapterSecretary
  );

  event LogIndex (
    uint24 index
  );
}