pragma solidity ^0.4.11;

import './ChapterStorage.sol';

/// @title Chapter National Storage
/// @author 97Network
contract ChapterNationalStorage {

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
}