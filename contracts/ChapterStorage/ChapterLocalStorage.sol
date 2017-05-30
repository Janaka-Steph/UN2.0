pragma solidity ^0.4.11;

import './ChapterStorage.sol';

/// @title Chapter Local Storage
/// @author 97Network
contract ChapterLocalStorage {

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