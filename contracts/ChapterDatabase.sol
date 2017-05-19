pragma solidity ^0.4.8;

import './ChapterInterface.sol';

/// @title Chapter Database
/// @author 97Network
contract ChapterDatabase /*is GDAOEnabled*/ {

   // [global, national, local]
   // [1, 1, 1]
   uint24[3] chapterId;

   enum Level {Local, National, Global}

   struct Forum {
       address[] members;
   }

   struct ExecutiveCommittee {
      address executiveCommitteeAddr;
      mapping(bytes32 => address) members;
   }

   struct BoardOfDirectors {
      address[] directors;
   }

   struct Secretariat {
       address secretary;
       address[] members;
   }

   struct Chapter {
    /// @dev Each chapter is composed of a forum, an executive committee, a board of directors and a secretariat
    /// Each chapter is chaired by a president and is managed by a secretary.
    // TODO explain index - https://medium.com/@robhitchens/solidity-crud-part-1-824ffa69509a
    uint index;
    uint24[3] chapterId;
    // II. Article 50 -	Principle of subsidiarity
    // 1. UN2.0 bodies are ordered in chapters of different levels.
    Level level;
    address president;
    Forum forum;
    ExecutiveCommittee executiveCommittee;
    BoardOfDirectors boardOfDirectors;
    Secretariat secretariat;
    uint24[3][] subChapters;
  }

  struct ChapterGlobal {
    address president;
    ExecutiveCommittee executiveCommittee;
    Forum forum;
    // Moderators: name => address
    mapping(bytes32 => address) moderators;
    Secretariat secretariat;
    mapping(uint24 => ChapterNational) chaptersNational;
  }

  struct ChapterNational {
    uint24 nationalChapterId;
    address president;
    Forum forum;
    ExecutiveCommittee executiveCommittee;
    address[] moderators;
    Secretariat secretariat;
    mapping(uint24 => ChapterLocal) chaptersLocal;
  }

  struct ChapterLocal {
    uint24 localChapterId;
    address president;
    Forum forum;
    ExecutiveCommittee executiveCommittee;
    address[] moderators;
    Secretariat secretariat;
  }

  // There is one global chapter
  ChapterGlobal chapterGlobal;
  //
  address[] private chapterIndex;

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
  event LogBody    (address indexed chapterId, uint index, address body);
  event LogChapter (address indexed chapterId, uint index, address chapter);
  event LogUpdateChapter(address indexed chapterId, uint index, bytes32 bodyType, address bodyAddr);



  /// @notice Check if chapter exist
  /// @param _chapterId The chapter ID
  /// @return bool
  function isExistingChapterLocal(uint24[3] _chapterId)
    public
    constant
    returns(bool isIndeed)
  {
    if (chapterIndex.length == 0) return false;

    // return chapterIndex[chapters[_chapterId].index] == _chapterId;
    // chaptersGlobal[_chapterId[0]].chaptersNational[_chapterId[1]].chaptersLocal[_chapterId[2]];
  }


  /// @notice Create global chapter
  /// @dev Called once. There is only one global chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return bool
  function createChapterGlobal(address _president, address _secretary) returns (bool _success) {
    ExecutiveCommittee executiveCommittee = ExecutiveCommittee({
      executiveCommitteeAddr: 0x1
    });

    executiveCommittee.members['name'] = 0x2;

    Forum memory forum = Forum({
      members: -1
    });

    Secretariat memory secretariat = Secretariat({
      secretary: _secretary,
      members: -1
    });

    var moderators = [];

    // push() returns the new length
    // uint index     =  chapterIndex.push(_chapterId) - 1;
    chapterGlobal = ChapterGlobal(_president, executiveCommittee, forum, moderators, secretariat);
    _success = true;
  }


   /// @notice Set chapter executive committee
   /// @param _chapterId The chapter ID
   /// @param _executives The executives
   /// @return bool
   function setExecutiveCommittee(uint24[3] _chapterId, address[] _executives) returns (bool _success) {
     if(!isExistingChapterLocal(chapterId)) throw;
       // If National
       if (_chapterId[2] == 0) {
          chapterGlobal
            .chaptersNational[ _chapterId[1] ]
            .executiveCommittee.members = _executives;
       // If Local
       } else {
          chapterGlobal
            .chaptersNational[ _chapterId[1] ]
            .chaptersLocal[ _chapterId[2] ]
            .executiveCommittee.members = _executives;
       }
       _success = true;
   }

   /// @notice Set chapter forum
   /// @param _chapterId The chapter ID
   /// @param _members The forum members
   /// @return bool
   function setForum(uint24[3] _chapterId, address[] _members) public returns(bool _success) {
    if(!isExistingChapterLocal(chapterId)) throw;
      // If National
      if (_chapterId[2] == 0) {
         chapterGlobal
           .chaptersNational[ _chapterId[1] ]
           .forum
           .members = _members;
      // If Local
      } else {
         chapterGlobal
           .chaptersNational[ _chapterId[1] ]
           .chaptersLocal[ _chapterId[2] ]
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
      if(!isExistingChapterLocal(chapterId)) throw;
       // If National
       if (_chapterId[2] == 0) {
          chapterGlobal
            .chaptersNational[ _chapterId[1] ]
            .secretariat = Secretariat(_secretary, _members);
       // If Local
       } else {
          chapterGlobal
            .chaptersNational[ _chapterId[1] ]
            .chaptersLocal[ _chapterId[2] ]
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
      if (_chapterId[2] == 0) {
         chapterGlobal
           .chaptersNational[ _chapterId[1] ]
           .president = _president;
      // If Local
      } else {
         chapterGlobal
           .chaptersNational[ _chapterId[1] ]
           .chaptersLocal[ _chapterId[2] ]
           .president = _president;
      }
      _success = true;
   }

   /// @notice Set chapter secretary
   /// @param _chapterId The chapter ID
   /// @param _secretary The new secretary
   /// @return bool
   function setChapterSecretary(uint24[3] _chapterId, address _secretary) returns (bool _success) {
     if(!isExistingChapterLocal(chapterId)) throw;
       // If National
       if (_chapterId[2] == 0) {
          chapterGlobal
            .chaptersNational[ _chapterId[1] ]
            .secretariat
            .secretary = _secretary;
       // If Local
       } else {
          chapterGlobal
            .chaptersNational[ _chapterId[1] ]
            .chaptersLocal[ _chapterId[2] ]
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