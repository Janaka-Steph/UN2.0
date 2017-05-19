pragma solidity ^0.4.11;

/// @title Chapter Storage
/// @author 97Network
contract ChapterStorage {

   // National chapter [000], Local chapter [00000], Sub-chapter [00]
   uint24[3] chapterId;

   enum Level {Local, National, Global}

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
    uint24 nationalChapterId;
    mapping(uint24 => SubChapter) nationalSubChapters;
    address president;
    Secretariat secretariat;
  }

  struct ChapterLocal {
    uint24 localChapterId;
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


  /// @notice Check if chapter exist
  /// @param _chapterId The chapter ID
  /// @return bool
  function isChapterLocalExists(uint24[3] _chapterId) public constant returns (bool) {
    if (chapterGlobal
          .chaptersNational[ _chapterId[0] ]
          .chaptersLocal[ _chapterId[1] ]
          .localChapterId != 0
       ) { return true; }
    else { return false; }
  }


  /// @notice Create global chapter
  /// @dev Called once. There is only one global chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return bool
  function createChapterGlobal(address _president, address _secretary) returns (bool _success) {
    chapterGlobal.president = _president;
    chapterGlobal.secretariat.secretary = _secretary;
    chapterGlobal.moderators['name2'] = 0x3;
    _success = true;
  }

   /// @notice Set chapter forum
   /// @param _chapterId The chapter ID
   /// @param _members The forum members
   /// @return bool
   function setForum(uint24[3] _chapterId, address[] _members) public returns(bool _success) {
    if(!isChapterLocalExists(chapterId)) throw;
      // If National
      if (_chapterId[1] == 0) { // if not local
         chapterGlobal
           .chaptersNational[ _chapterId[0] ]
           .forum
           .members = _members;
      // If Local
      } else {
         chapterGlobal
           .chaptersNational[ _chapterId[0] ]
           .chaptersLocal[ _chapterId[1] ]
           .forum
           .members = _members;
      }
      _success = true;
   }

   /// @notice Set chapter Secretariat
   /// @param _chapterId The chapter ID
   /// @param _secretary The secretary
   /// @param _members The members
   /// @return bool
   function setSecretariat(uint24[3] _chapterId, address _secretary, address[] _members) returns (bool _success) {
      if(!isChapterLocalExists(chapterId)) throw;
       // If National
       if (_chapterId[1] == 0) { // if not local
          chapterGlobal.chaptersNational[ _chapterId[0] ].secretariat.secretary = _secretary;
          chapterGlobal.chaptersNational[ _chapterId[0] ].secretariat.members = _members;
       // If Local
       } else {
          chapterGlobal
            .chaptersNational[ _chapterId[0] ]
            .chaptersLocal[ _chapterId[1] ]
            .secretariat = Secretariat(_secretary, _members);
       }
       _success = true;
   }

   /// @notice Set chapter president
   /// @param _chapterId The chapter ID
   /// @param _president The new president
   /// @return bool
   function setChapterPresident(uint24[3] _chapterId, address _president) returns (bool _success) {
      // If National
      if (_chapterId[1] == 0) {
         chapterGlobal
           .chaptersNational[ _chapterId[0] ]
           .president = _president;
      // If Local
      } else {
         chapterGlobal
           .chaptersNational[ _chapterId[0] ]
           .chaptersLocal[ _chapterId[1] ]
           .president = _president;
      }
      _success = true;
   }

   /// @notice Set chapter secretary
   /// @param _chapterId The chapter ID
   /// @param _secretary The new secretary
   /// @return bool
   function setChapterSecretary(uint24[3] _chapterId, address _secretary) returns (bool _success) {
     if(!isChapterLocalExists(chapterId)) throw;
       // If National
       if (_chapterId[1] == 0) {
          chapterGlobal
            .chaptersNational[ _chapterId[0] ]
            .secretariat
            .secretary = _secretary;
       // If Local
       } else {
          chapterGlobal
            .chaptersNational[ _chapterId[0] ]
            .chaptersLocal[ _chapterId[1] ]
            .secretariat
            .secretary = _secretary;
       }
       _success = true;
   }

/*
  // @notice Get chapter national
  // @param _chapterNationalId The national chapter ID
  // @return ChapterNational
  function getChapterNational(uint24 _chapterNationalId) public constant returns (ChapterNational _chapterNational) {
    _chapterNational = chapterGlobal.chaptersNational[ _chapterNationalId ];
  }
*/

/*
  // @notice getChapterCount
  // @return uint
  function getChapterCount()
    public
    constant
    returns(uint count)
  {
    return  chapterIndex.length;
  }

  // @notice getChapterAtIndex
  // @param index The Chapter index
  // @return uint24[3]
  function getChapterAtIndex(uint index)
    public
    constant
    returns(uint24[3])
  {
    return  chapterIndex[index];
  }
*/
}