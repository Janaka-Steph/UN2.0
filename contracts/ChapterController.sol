pragma solidity ^0.4.11;

import './Registry.sol';

/// @title Chapter Controller
/// @author 97Network
contract ChapterController {
  /// @notice Create global chapter
  /// @dev Called once. There is only one global chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return bool
  function createChapterGlobal(address _president, address _secretary) returns (bool _success) {
     // lock = false
     // get ChapterDatabase
     // if is BoardOfDirectors
     // ChapterDatabase.createChapterGlobal(_board, _chapterId, _president, _secretary)
     // lock = true
  }

  /// @notice Create National chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return ChapterNational
  function createChapterNational(address _president, address _secretary) returns (bool _success) {

  }

  /// @notice Create Local chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return ChapterLocal
  function createChapterLocal(address _president, address _secretary) returns (bool _success) {

  }

  /// @notice Set chapter executive committee
  /// @param _chapterId The chapter ID
  /// @param _executives The executives
  /// @return bool
  function setExecutiveCommittee(uint24[3] _chapterId, address[] _executives) returns (bool _success) {
    //VotingSystem = ContractProvider(GDAO).getContract(name);
    // Legislator.vote();
    //if (VotingSystem.isPassed) {
       //ChapterDatabase = ContractProvider(GDAO).getContract('chapterDatabase');
       //ChapterDatabase.setExecutiveCommittee();
    //}
  }

  /// @notice Set chapter forum
  /// @param _chapterId The chapter ID
  /// @param _members The forum members
  /// @return bool
  function setForum(uint24[3] _chapterId, address[] _members) public returns(bool _success) {

  }

  /// @notice Set chapter Secretariat
  /// @param _chapterId The chapter ID
  /// @param _secretary The secretary
  /// @param _members The members
  /// @return bool
  function setSecretariat(uint24[3] _chapterId, address _secretary, address[] _members) returns (bool _success) {

  }

  /// @notice Set chapter president
  /// @param _chapterId The chapter ID
  /// @param _president The new president
  /// @return bool
  function setNewPresident(uint24[3] _chapterId, address _president) returns (bool _success) {

  }

  /// @notice Set new secretary
  /// @param _chapterId The Chapter ID
  /// @param _secretary The new secretary
  /// @return bool
  function setNewSecretary(uint24[3] _chapterId, address _secretary) returns (bool _success) {

  }
}