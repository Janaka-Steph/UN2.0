pragma solidity ^0.4.11;

import './Registry.sol';
import './ChapterController.sol';

/// @title Chapter Interface
/// @author 97Network
contract ChapterInterface is Registry {
  Registry registry;

  function ChapterInterface(address _registryAddress) {
    registryAddress = _registryAddress;
    registry = Registry(registryAddress);
  }

  /// @notice Create global chapter
  /// @dev Called once. There is only one global chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return bool
  function createChapterGlobal(address _president, address _secretary) returns (bool _success) {
    _success = ChapterController(registry.getContract('c:chapter')).createChapterGlobal(_president, _secretary);
    return _success;
  }

  /// @notice Create National chapter
  /// @param _chapterNationalId The chapter National Id
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return ChapterNational
  function createChapterNational(uint24 _chapterNationalId, address _president, address _secretary) returns (bool _success) {
    _success = ChapterController(registry.getContract('c:chapter')).createChapterNational(_chapterNationalId, _president, _secretary);
    return _success;
  }

  /// @notice Create Local chapter
  /// @param _chapterNationalId The chapter National Id
  /// @param _chapterLocalId The chapter Local Id
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return ChapterLocal
  function createChapterLocal(uint24 _chapterNationalId, uint24 _chapterLocalId, address _president, address _secretary) returns (bool _success) {
    _success = ChapterController(registry.getContract('c:chapter')).createChapterLocal(_chapterNationalId, _chapterLocalId, _president, _secretary);
    return _success;
  }

  /// @notice Set chapter forum
  /// @param _chapterId The chapter ID
  /// @param _members The forum members
  /// @return bool
  function setForum(uint24[3] _chapterId, address[] _members) public returns(bool _success) {
    _success = ChapterController(registry.getContract('c:chapter')).setForum(_chapterId, _members);
    return _success;
  }

  /// @notice Set chapter Secretariat
  /// @param _chapterId The chapter ID
  /// @param _secretary The secretary
  /// @param _members The members
  /// @return bool
  function setSecretariat(uint24[3] _chapterId, address _secretary, address[] _members) returns (bool _success) {
    _success = ChapterController(registry.getContract('c:chapter')).setSecretariat(_chapterId, _secretary, _members);
    return _success;
  }

  /// @notice Set new secretary
  /// @param _chapterId The Chapter ID
  /// @param _secretary The new secretary
  /// @return bool
  function setChapterSecretary(uint24[3] _chapterId, address _secretary) returns (bool _success) {
    _success = ChapterController(registry.getContract('c:chapter')).setChapterSecretary(_chapterId, _secretary);
    return _success;
  }

  /// @notice Set chapter president
  /// @param _chapterId The chapter ID
  /// @param _president The new president
  /// @return bool
  function setChapterPresident(uint24[3] _chapterId, address _president) returns (bool _success) {
    _success = ChapterController(registry.getContract('c:chapter')).setChapterPresident(_chapterId, _president);
    return _success;
  }


  //
  // Art 56 - 1. Each chapter's board of directors is composed of the chapter president,
  // the chapter secretary and the moderators who the chapter president will consider necessary
  // function getBoardOfDirectorsByChapterId(uint24[3] _chapterId) returns (address[] _boardOfDirectors) {}
}