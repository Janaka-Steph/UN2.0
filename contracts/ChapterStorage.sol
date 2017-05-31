pragma solidity ^0.4.11;

import './gdao/GDAO.sol';

/// @title Chapter Storage
/// @author 97Network
contract ChapterStorage is GDAO {

  // chapterId: National chapter [000], Local chapter [00000], Sub-chapter [00]

  // Number of local chapters
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


  /// @notice Create global chapter
  /// @dev Called once. There is only one global chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return bool
  function createChapterGlobal(address _president, address _secretary) /*isCallerValid*/ returns (bool _success) {
    chapterGlobal.president = _president;
    chapterGlobal.secretariat.secretary = _secretary;
    chapterGlobal.moderators['name2'] = 0x3;
    _success = true;
    return _success;
  }

  /// @notice Create National chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return bool
  function createChapterNational(address _president, address _secretary) returns (bool _success) {
    // Increment index
    chaptersNationalIndex = chaptersNationalIndex + 1;
    LogIndex(chaptersNationalIndex);
    // Create a national chapter
    chapterGlobal.chaptersNational[ chaptersNationalIndex ].chapterNationalId = chaptersNationalIndex;
    chapterGlobal.chaptersNational[ chaptersNationalIndex ].president = _president;
    chapterGlobal.chaptersNational[ chaptersNationalIndex ].secretariat.secretary = _secretary;
    _success = true;
    return _success;
  }

  /// @notice Check if national chapter exists
  /// @param _chapterNationalId The national chapter ID
  /// @return bool
  function isChapterNationalExists(uint24 _chapterNationalId) public constant returns (bool) {
     if (chapterGlobal
           .chaptersNational[ _chapterNationalId ]
           .chapterNationalId != 0
        ) { return true; }
     else { return false; }
  }

  /// @notice Create Local chapter
  /// @param _chapterNationalId The chapter National Id
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return bool
  function createChapterLocal(uint24 _chapterNationalId, address _president, address _secretary) returns (bool _success) {
    // Increment index
    chaptersLocalIndex = chaptersLocalIndex + 1;
    LogIndex(chaptersLocalIndex);
    // Create local chapter
    chapterGlobal.chaptersNational[ _chapterNationalId ].chaptersLocal[ chaptersLocalIndex ].chapterLocalId = chaptersLocalIndex;
    chapterGlobal.chaptersNational[ _chapterNationalId ].chaptersLocal[ chaptersLocalIndex ].president = _president;
    chapterGlobal.chaptersNational[ _chapterNationalId ].chaptersLocal[ chaptersLocalIndex ].secretariat.secretary = _secretary;
    _success = true;
    return _success;
  }

  /// @notice Check if local chapter exists
  /// @param _chapterNationalId The national chapter ID
  /// @param _chapterLocalId The local chapter ID
  /// @return bool
  function isChapterLocalExists(uint24 _chapterNationalId, uint24 _chapterLocalId) public constant returns (bool) {
    if (chapterGlobal
          .chaptersNational[ _chapterNationalId ]
          .chaptersLocal[ _chapterLocalId ]
          .chapterLocalId != 0
       ) { return true; }
    else { return false; }
  }



  /**
  * GETTERS
  *
  */

   /// @notice Get national chapter president
   /// @param _chapterNationalId The national chapter ID
   /// @return address
   function getChapterNationalPresident(uint24 _chapterNationalId) constant
    returns (address president) {
      return chapterGlobal
                .chaptersNational[ _chapterNationalId ]
                .president;
   }

   /// @notice Get national chapter secretary
   /// @param _chapterNationalId The national chapter ID
   /// @return address
   function getChapterNationalSecretary(uint24 _chapterNationalId) constant
    returns (address secretary) {
      return chapterGlobal
                .chaptersNational[ _chapterNationalId ]
                .secretariat
                .secretary;
   }

   /// @notice Get local chapter president
   /// @param _chapterNationalId The national chapter ID
   /// @param _chapterLocalId The local chapter ID
   /// @return address
   function getChapterLocalPresident(uint24 _chapterNationalId, uint24 _chapterLocalId) constant
    returns (address president) {
      return chapterGlobal
                .chaptersNational[ _chapterNationalId ]
                .chaptersLocal[ _chapterLocalId ]
                .president;
   }

   /// @notice Get local chapter secretary
   /// @param _chapterNationalId The national chapter ID
   /// @param _chapterLocalId The local chapter ID
   /// @return address
   function getChapterLocalSecretary(uint24 _chapterNationalId, uint24 _chapterLocalId) constant
    returns (address secretary) {
      return chapterGlobal
                .chaptersNational[ _chapterNationalId ]
                .chaptersLocal[ _chapterLocalId ]
                .secretariat
                .secretary;
   }



  /**
  * CHAPTER BODY SETTERS
  *
  */

   /// @notice Set chapter national forum
   /// @param _chapterNationalId The national chapter ID
   /// @param _members The forum members
   /// @return bool
   function setForumChapterNational(uint24 _chapterNationalId, address[] _members) public returns(bool _success) {
     if(!isChapterNationalExists(_chapterNationalId)) throw;
     chapterGlobal
       .chaptersNational[ _chapterNationalId ]
       .forum
       .members = _members;
     _success = true;
     return _success;
   }

   /// @notice Set chapter local forum
   /// @param _chapterNationalId The national chapter ID
   /// @param _chapterLocalId The local chapter ID
   /// @param _members The forum members
   /// @return bool
   function setForumChapterLocal(uint24 _chapterNationalId, uint24 _chapterLocalId, address[] _members) public returns(bool _success) {
     if(!isChapterLocalExists(_chapterNationalId, _chapterLocalId)) throw;
     chapterGlobal
       .chaptersNational[ _chapterNationalId ]
          .chaptersLocal[ _chapterLocalId ]
          .forum
          .members = _members;
     _success = true;
     return _success;
  }


   /// @notice Set chapter national Secretariat
   /// @param _chapterNationalId The national chapter ID
   /// @param _secretary The secretary
   /// @param _members The members
   /// @return bool
   function setSecretariatChapterNational(uint24 _chapterNationalId, address _secretary, address[] _members) returns (bool _success) {
     if(!isChapterNationalExists(_chapterNationalId)) throw;
     chapterGlobal.chaptersNational[ _chapterNationalId ].secretariat.secretary = _secretary;
     chapterGlobal.chaptersNational[ _chapterNationalId ].secretariat.members = _members;
     _success = true;
     return _success;
   }

   /// @notice Set chapter local Secretariat
   /// @param _chapterNationalId The national chapter ID
   /// @param _chapterLocalId The local chapter ID
   /// @param _secretary The secretary
   /// @param _members The members
   /// @return bool
   function setSecretariatChapterLocal(uint24 _chapterNationalId, uint24 _chapterLocalId, address _secretary, address[] _members) returns (bool _success) {
     if(!isChapterLocalExists(_chapterNationalId,_chapterLocalId)) throw;
     chapterGlobal
       .chaptersNational[ _chapterNationalId ]
       .chaptersLocal[ _chapterLocalId ]
       .secretariat = Secretariat(_secretary, _members);
     _success = true;
     return _success;
   }

   /// @notice Set national chapter president
   /// @param _chapterNationalId The national chapter ID
   /// @param _president The new president
   /// @return bool
   function setChapterNationalPresident(uint24 _chapterNationalId, address _president) returns (bool _success) {
     if(!isChapterNationalExists(_chapterNationalId)) throw;
     chapterGlobal
       .chaptersNational[ _chapterNationalId ]
       .president = _president;
       _success = true;
       return _success;
   }

   /// @notice Set local chapter president
   /// @param _chapterNationalId The national chapter ID
   /// @param _chapterLocalId The local chapter ID
   /// @param _president The new president
   /// @return bool
   function setChapterLocalPresident(uint24 _chapterNationalId, uint24 _chapterLocalId, address _president) returns (bool _success) {
     if(!isChapterLocalExists(_chapterNationalId, _chapterLocalId)) throw;
     chapterGlobal
       .chaptersNational[ _chapterNationalId ]
       .chaptersLocal[ _chapterLocalId ]
       .president = _president;
     _success = true;
     return _success;
   }

   /// @notice Set national chapter secretary
   /// @param _chapterNationalId The national chapter ID
   /// @param _secretary The new secretary
   /// @return bool
   function setChapterNationalSecretary(uint24 _chapterNationalId, address _secretary) returns (bool _success) {
     if(!isChapterNationalExists(_chapterNationalId)) throw;
     chapterGlobal
       .chaptersNational[ _chapterNationalId ]
       .secretariat
       .secretary = _secretary;
     _success = true;
     return _success;
   }

   /// @notice Set local chapter secretary
   /// @param _chapterNationalId The national chapter ID
   /// @param _chapterLocalId The local chapter ID
   /// @param _secretary The new secretary
   /// @return bool
   function setChapterLocalSecretary(uint24 _chapterNationalId, uint24 _chapterLocalId, address _secretary) returns (bool _success) {
     if(!isChapterLocalExists(_chapterNationalId, _chapterLocalId)) throw;
     chapterGlobal
       .chaptersNational[ _chapterNationalId ]
       .chaptersLocal[ _chapterLocalId ]
       .secretariat
       .secretary = _secretary;
     _success = true;
     return _success;
  }
}