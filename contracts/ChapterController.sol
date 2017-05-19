pragma solidity ^0.4.11;

import './Registry.sol';
import './ChapterStorage.sol';

/// @title Chapter Controller
/// @author 97Network
contract ChapterController is Registry {
  Registry registry;

  function ChapterController(address _registryAddress) {
    registryAddress = _registryAddress;
    registry = Registry(registryAddress);
  }
  /// @notice Create Global chapter
  /// @dev Called once. There is only one global chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return bool
  function createChapterGlobal(address _president, address _secretary) returns (bool _success) {
     // if is BoardOfDirectors
     _success = ChapterStorage(registry.getContract('s:chapter')).createChapterGlobal(_president, _secretary);
     return _success;
  }

  /// @notice Create National chapter
  /// @param _chapterNationalId The chapter National Id
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return ChapterNational
  function createChapterNational(uint24 _chapterNationalId, address _president, address _secretary) returns (bool _success) {
     Registry registry = Registry(registryAddress);
     // if is BoardOfDirectors
     _success = ChapterStorage(registry.getContract('s:chapter')).createChapterNational(_chapterNationalId, _president, _secretary);
     return _success;
  }

  /// @notice Create Local chapter
  /// @param _chapterNationalId The chapter National Id
  /// @param _chapterLocalId The chapter Local Id
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return ChapterLocal
  function createChapterLocal(uint24 _chapterNationalId, uint24 _chapterLocalId, address _president, address _secretary) returns (bool _success) {
     // if is BoardOfDirectors
     _success = ChapterStorage(registry.getContract('s:chapter')).createChapterLocal(_chapterNationalId, _chapterLocalId, _president, _secretary);
     return _success;
  }

  /// @notice Set chapter forum
  /// @param _chapterId The chapter ID
  /// @param _members The forum members
  /// @return bool
  function setForum(uint24[3] _chapterId, address[] _members) public returns(bool _success) {
    //VotingSystem = ContractProvider(GDAO).getContract(name);
    // Legislator.vote();
    //if (VotingSystem.isPassed) {
     _success = ChapterStorage(registry.getContract('s:chapter')).setForum(_chapterId, _members);
     return true;
    //}
    //else {
    //return false;
    //}
  }

  /// @notice Set chapter Secretariat
  /// @param _chapterId The chapter ID
  /// @param _secretary The secretary
  /// @param _members The members
  /// @return bool
  function setSecretariat(uint24[3] _chapterId, address _secretary, address[] _members) returns (bool _success) {
    //VotingSystem = ContractProvider(GDAO).getContract(name);
    // Legislator.vote();
    //if (VotingSystem.isPassed) {
     _success = ChapterStorage(registry.getContract('s:chapter')).setSecretariat(_chapterId, _secretary, _members);
     return true;
    //}
    //else {
    //return false;
    //}
  }

  /// @notice Set new secretary
  /// @param _chapterId The Chapter ID
  /// @param _secretary The new secretary
  /// @return bool
  function setChapterSecretary(uint24[3] _chapterId, address _secretary) returns (bool _success) {
     _success = ChapterStorage(registry.getContract('s:chapter')).setChapterSecretary(_chapterId, _secretary);
     return true;
  }

  /// @notice Set chapter president
  /// @param _chapterId The chapter ID
  /// @param _president The new president
  /// @return bool
  function setChapterPresident(uint24[3] _chapterId, address _president) returns (bool _success) {
     _success = ChapterStorage(registry.getContract('s:chapter')).setChapterPresident(_chapterId, _president);
     return true;
  }
}